# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
# rubocop:todo Style/Documentation

require_relative './resource_group'
require_relative './resource_modifier'

class Job
  attr_reader :name

  def initialize(
    name:, strata: :none, category: :none, subcategory: :none,
    **options
  )
    @name = name
    @strata = strata
    @category = category
    @subcategory = subcategory

    @options = options
    @options.each_value(&:freeze)
    @options.freeze
  end

  def output
    ResourceGroup.new(@options[:output] || {})
  end

  def upkeep
    ResourceGroup.new(@options[:upkeep] || {})
  end

  def amenities_output
    @options[:amenities_output] || 0
  end

  def stability_modifier
    @options[:stability_modifier] || 0
  end

  def habitability_modifier
    @options[:habitability_modifier] || 0
  end

  def colony_attribute_modifiers
    ResourceModifier.new(@options[:colony_attribute_modifiers] || {})
  end

  def empire_attribute_modifiers
    ResourceModifier.new(@options[:empire_attribute_modifiers] || {})
  end

  def worker_housing_modifier
    ResourceModifier.new(@options[:worker_housing_modifier] || {})
  end

  def worker_political_power_modifier
    ResourceModifier.new(@options[:worker_political_power_modifier] || {})
  end

  def pop_happiness_modifiers
    @options[:pop_happiness_modifiers] || 0
  end

  def all_job_output_modifiers(job)
    modifier = @options[:all_job_output_modifiers] || {}

    modifier = modifier.call(job) if modifier.is_a?(Proc) && modifier.lambda?

    ResourceModifier.new(modifier)
  end

  # Strata
  def ruler?
    @strata == :ruler
  end

  def specialist?
    @strata == :specialist
  end

  def worker?
    @strata == :worker
  end

  def slave?
    @strata == :slave
  end

  def complex_drone?
    @strata == :complex_drone
  end

  def menial_drone?
    @strata == :menial_drone
  end

  # Categories
  def farmer?
    @category == :farmers
  end

  def miner?
    @category == :miners
  end

  def strategic_resource_miner?
    miner? and @subcategory == :strategic_resource_miners
  end

  def livestock?
    @category == :livestock
  end

  def technician?
    @category == :technicians
  end

  def politician?
    @category == :politicians
  end

  def executive?
    politician? and @subcategory == :executives
  end

  def noble?
    politician? and @subcategory == :nobles
  end

  def administrator?
    @category == :administrators
  end

  def manager?
    administrator? and @subcategory == :managers
  end

  def priest?
    administrator? and @subcategory == :priests
  end

  def telepath?
    administrator? and @subcategory == :telepaths
  end

  def researcher?
    @category == :researchers
  end

  def metallurgist?
    @category == :metallurgists
  end

  def culture_worker?
    @category == :culture_workers
  end

  def evaluator?
    @category == :evaluators
  end

  def refiner?
    @category == :refiners
  end

  def translucer?
    @category == :translucers
  end

  def chemist?
    @category == :chemists
  end

  def artisan?
    @category == :artisans
  end

  def bio_trophy?
    @category == :bio_trophies
  end

  def pop_assembler?
    @category == :pop_assemblers
  end

  def necro_apprentice?
    pop_assembler? and @subcategory == :necro_apprentices
  end

  def merchant?
    @category == :merchants
  end

  def entertainer?
    @category == :entertainers
  end

  def soldier?
    @category == :soldiers
  end

  def enforcer?
    @category == :enforcers
  end

  def doctor?
    @category == :doctors
  end

  def self.lookup(name)
    case name
    when Job
      name
    when Symbol
      const_get(name.to_s.split('_').map(&:capitalize).join.to_sym)
    when String
      constants.find { |x| x.is_a?(Job) and x.name == name }
    end
  end
end

# rubocop:enable Metrics/ClassLength, Style/Documentation

Dir[File.join(__dir__, 'job', '*.rb')].sort.each { |file| require file }
