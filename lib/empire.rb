# frozen_string_literal: true

require_relative './mixins'
require_relative './resource_group'
require_relative './resource_modifier'
require_relative './sector'

# rubocop:todo Metrics/ClassLength, Style/Documentation

class Empire
  include OutputsResources

  attr_reader :ruler, :ethics, :civics, :technology

  # rubocop:todo Metrics/AbcSize, Metrics/MethodLength, Metrics/ParameterLists
  def initialize(founder_species:, ruler:, government: nil, ethics: [],
                 civics: [], technology: {}, technologies: [], edicts: [],
                 traditions: [])
    @founder_species = founder_species
    @ruler = ruler
    @ruler.role = :ruler
    @government = government
    @ethics = ethics.dup
    @civics = civics.dup
    @technology = technology.dup
    @technologies = technologies.dup
    @edicts = edicts.dup
    @traditions = traditions.dup

    @sectors = []
    @stations = []
    @trade_deals = []

    %i[physics society engineering].each do |science|
      @technology[science] = [] unless @technology.key?(science)
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/ParameterLists

  def add_sector(sector)
    @sectors << sector
  end

  def add_station(station)
    @stations << station
    station.empire = self
  end

  def add_trade_deal(deal)
    @trade_deals << deal
  end

  # rubocop:todo Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
  def job_output_modifiers(job)
    modifiers = [@government, @ruler, @edicts, @technologies, @traditions, @civics].compact.flatten.filter do |x|
      x.respond_to?(:job_output_modifiers)
    end

    modifier = modifiers.reduce(ResourceModifier.new) { |sum, m| sum + m.job_output_modifiers(job) }
    modifier += @founder_species.founder_species_job_output_modifiers(job) unless @founder_species.nil?

    # FIXME: Replace with ethics classes
    if @ethics.include?(:fanatic_egalitarian) && job.worker.specialist?
      modifier += ResourceModifier::MultiplyAllProducedResources.new(0.1)
    end

    modifier += ResourceModifier.new(trade: { multiplicative: 0.1 }) if @ethics.include?(:xenophile)

    # FIXME: Replace hard-coded civics
    if @civics.include?(:meritocracy) && job.worker.specialist?
      modifier += ResourceModifier::MultiplyAllProducedResources.new(0.1)
    end

    modifier += ResourceModifier.new(unity: { multiplicative: 0.15 }) if @civics.include?(:beacon_of_liberty)

    # FIXME: Replace hard-coded technology
    if @technology[:society].include?(:eco_simulation) && job.farmer?
      modifier += ResourceModifier.new(food: { multiplicative: 0.2 })
    end

    modifier
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

  def job_upkeep_modifiers(job)
    modifier = ResourceModifier.new

    modifier += @government.job_upkeep_modifiers(job) unless @government.nil?

    @edicts.each do |edict|
      modifier += edict.job_upkeep_modifiers(job)
    end

    @technologies.each { |t| modifier += t.job_upkeep_modifiers(job) }
    @traditions.each { |t| modifier += t.job_upkeep_modifiers(job) }

    modifier
  end

  def job_colony_attribute_modifiers(job)
    modifiers = [@government, @ruler, @edicts, @technologies, @traditions, @civics].compact.flatten.filter do |x|
      x.respond_to?(:job_colony_attribute_modifiers)
    end

    modifiers.reduce(ResourceModifier.new) { |sum, m| sum + m.job_colony_attribute_modifiers(job) }
  end

  def job_empire_attribute_modifiers(job)
    modifiers = [@government, @ruler, @edicts, @technologies, @traditions, @civics].compact.flatten.filter do |x|
      x.respond_to?(:job_empire_attribute_modifiers)
    end

    modifiers.reduce(ResourceModifier.new) { |sum, m| sum + m.job_empire_attribute_modifiers(job) }
  end

  def job_amenities_output_modifier(job)
    modifiers = [@government, @ruler, @edicts, @technologies, @traditions, @civics].compact.flatten.filter do |x|
      x.respond_to?(:job_amenities_output_modifier)
    end

    modifiers.reduce(0) { |sum, m| sum + m.job_amenities_output_modifier(job) }
  end

  def job_stability_modifier(job)
    modifiers = [@government, @ruler, @edicts, @technologies, @traditions, @civics].compact.flatten.filter do |x|
      x.respond_to?(:job_stability_modifier)
    end

    modifiers.reduce(0) { |sum, m| sum + m.job_stability_modifier(job) }
  end

  def job_worker_housing_modifier(job)
    modifiers = [@government, @ruler, @edicts, @technologies, @traditions, @civics].compact.flatten.filter do |x|
      x.respond_to?(:job_worker_housing_modifier)
    end

    modifiers.reduce(ResourceModifier.new) { |sum, m| sum + m.job_worker_housing_modifier(job) }
  end

  def colony_attribute_modifiers
    modifiers = [@government, @ruler, @edicts, @technologies, @traditions, @civics].compact.flatten.filter do |x|
      x.respond_to?(:colony_attribute_modifiers)
    end

    modifiers.reduce(ResourceModifier.new) { |sum, m| sum + m.colony_attribute_modifiers }
  end

  def mining_station_modifiers
    modifier = ResourceModifier.new
    modifier += @ruler.mining_station_modifiers if @ruler

    modifier
  end

  def research_station_modifiers
    ResourceModifier.new
  end

  def pop_output_modifiers(_pop)
    modifier = ResourceModifier.new

    modifier += ResourceModifier.new({ trade: { multiplicative: 0.1 } }) if @ethics.include?(:xenophile)

    modifier
  end

  def stability_modifier
    modifier = 0

    modifier += 5 if @civics.include?(:shared_burdens)

    modifier
  end

  def empire_base_modifiers
    modifier = ResourceModifier.new
    modifier += @ruler.empire_base_modifiers

    modifier += ResourceModifier.new(unity: { multiplicative: 0.15 }) if @civics.include?(:beacon_of_liberty)

    modifier
  end

  # rubocop:todo Metrics/MethodLength
  def empire_base_modified_output
    empire_base = ResourceGroup.new({
                                      energy: 20,
                                      minerals: 20,
                                      food: 10,
                                      physics_research: 10,
                                      society_research: 10,
                                      engineering_research: 10,
                                      unity: 5,
                                      consumer_goods: 10,
                                      alloys: 5
                                    })

    empire_base << ResourceModifier.new({
                                          energy: { multiplicative: -1 },
                                          minerals: { multiplicative: -1 },
                                          food: { multiplicative: -1 },
                                          physics_research: { multiplicative: -1 },
                                          society_research: { multiplicative: -1 },
                                          engineering_research: { multiplicative: -1 },
                                          unity: { multiplicative: -1 },
                                          consumer_goods: { multiplicative: -1 },
                                          alloys: { multiplicative: -1 }
                                        })

    empire_base << empire_base_modifiers

    empire_base
  end
  # rubocop:enable Metrics/MethodLength

  def output
    output = [@sectors, @stations, @trade_deals].flatten.map(&:output).reduce(ResourceGroup.new, &:+)

    output + empire_base_modified_output
  end

  def upkeep
    [@sectors, @stations, @trade_deals].flatten.map(&:upkeep).reduce(ResourceGroup.new, &:+)
  end

  def attributes
    return @attributes if @attributes

    empire_attributes = ResourceGroup.new({ naval_capacity: 20 })

    modifiers = [@government, @ruler, @edicts, @technologies, @traditions, @civics,
                 @sectors].compact.flatten.filter do |x|
      x.respond_to?(:empire_attribute_modifiers)
    end

    empire_attributes << modifiers.reduce(ResourceModifier.new) { |sum, m| sum + m.empire_attribute_modifiers }

    @attributes = empire_attributes.resolve
    @attributes
  end

  def naval_capacity
    attributes[:naval_capacity] || 0
  end
end

# rubocop:enable Metrics/ClassLength, Style/Documentation
