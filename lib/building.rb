# frozen_string_literal: true

require_relative './job'
require_relative './resource_group'
require_relative './resource_modifier'

# rubocop:todo Style/Documentation

class Building
  attr_reader :name

  def initialize(name:, **options)
    @name = name

    @options = options.dup
    @options.each_value(&:freeze)
    @options.freeze
  end

  def max_jobs
    @options.fetch(:max_jobs, {})
  end

  def amenities_output
    @options.fetch(:amenities_output, 0)
  end

  def housing
    @options.fetch(:housing, 0)
  end

  def stability_modifier
    @options.fetch(:stability_modifier, 0)
  end

  def output
    ResourceGroup.new(@options.fetch(:output, {}))
  end

  def upkeep
    ResourceGroup.new(@options.fetch(:upkeep, {}))
  end

  def job_output_modifiers(job)
    modifier = @options.fetch(:job_output_modifiers, {})

    modifier = modifier.call(job) if modifier.is_a?(Proc) && modifier.lambda?

    ResourceModifier.new(modifier)
  end

  def colony_attribute_modifiers
    ResourceModifier.new(@options.fetch(:colony_attribute_modifiers, {}))
  end

  def self.tier1_building(name:, job:)
    Building.new(
      name: name,
      max_jobs: { job => 2 },
      upkeep: { energy: 2 }
    )
  end

  def self.tier2_building(name:, job:, strategic_resource:)
    Building.new(
      name: name,
      max_jobs: { job => 4 },
      upkeep: { energy: 5, strategic_resource => 1 }
    )
  end

  def self.tier3_building(name:, job:, strategic_resource:)
    Building.new(
      name: name,
      max_jobs: { job => 6 },
      upkeep: { energy: 8, strategic_resource => 2 }
    )
  end

  def self.lookup(name)
    case name
    when Building
      name
    when Symbol
      const_get(name.to_s.split('_').map(&:capitalize).join.to_sym)
    when String
      constants.find { |x| x.is_a?(Job) and x.name == name }
    end
  end
end

# rubocop:enable Style/Documentation

Dir[File.join(__dir__, 'building', '*.rb')].sort.each { |file| require file }
