# frozen_string_literal: true

require_relative './job'
require_relative './resource_group'
require_relative './resource_modifier'

# rubocop:todo Style/Documentation

class District
  attr_reader :name, :housing, :max_jobs, :colony_attribute_modifiers

  def initialize(name:, housing: 0, max_jobs: {}, colony_attribute_modifiers: {},
                 upkeep: { energy: 2 })
    @name = name
    @housing = housing
    @max_jobs = max_jobs.dup
    @colony_attribute_modifiers = ResourceModifier.new(colony_attribute_modifiers)
    @upkeep = ResourceGroup.new(upkeep)
  end

  def upkeep
    @upkeep.dup
  end

  def empire_attribute_modifiers
    ResourceModifier::NONE
  end
end

# rubocop:enable Style/Documentation

Dir[File.join(__dir__, 'district', '*.rb')].sort.each { |file| require file }
