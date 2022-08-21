# frozen_string_literal: true

require_relative './mixins'
require_relative './resource_group'
require_relative './resource_modifier'
require_relative './sector'

class Empire
  include OutputsResources

  attr_reader :ruler, :ethics, :civics, :technology

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

  def job_output_modifiers(job)
    modifier = ResourceModifier.new
    modifier += @ruler.job_output_modifiers(job)
    modifier += @government.job_output_modifiers(job) unless @government.nil?
    modifier += @founder_species.founder_species_job_output_modifiers(job) unless @founder_species.nil?

    if @ethics.include?(:fanatic_egalitarian) && job.worker.specialist?
      modifier += ResourceModifier.multiplyAllProducedResources(0.1)
    end

    modifier += ResourceModifier.new(trade: { multiplicative: 0.1 }) if @ethics.include?(:xenophile)

    if @civics.include?(:meritocracy) && job.worker.specialist?
      modifier += ResourceModifier.multiplyAllProducedResources(0.1)
    end

    modifier += ResourceModifier.new(unity: { multiplicative: 0.15 }) if @civics.include?(:beacon_of_liberty)

    if @technology[:society].include?(:eco_simulation) && job.farmer?
      modifier += ResourceModifier.new(food: { multiplicative: 0.2 })
    end

    @edicts.each do |edict|
      modifier += edict.job_output_modifiers(job)
    end

    @civics.filter { |c| c.is_a?(Modifier) }.each do |civic|
      modifier += civic.job_output_modifiers(job)
    end

    @technologies.each { |t| modifier += t.job_output_modifiers(job) }
    @traditions.each { |t| modifier += t.job_output_modifiers(job) }

    modifier
  end

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
    modifier = ResourceModifier.new

    modifier += @government.job_colony_attribute_modifiers(job) unless @government.nil?

    @edicts.each do |edict|
      modifier += edict.job_colony_attribute_modifiers(job)
    end

    @civics.filter { |c| c.is_a?(Modifier) }.each do |civic|
      modifier += civic.job_colony_attribute_modifiers(job)
    end

    @technologies.each { |t| modifier += t.job_colony_attribute_modifiers(job) }
    @traditions.each { |t| modifier += t.job_colony_attribute_modifiers(job) }

    modifier
  end

  def job_empire_attribute_modifiers(job)
    modifier = ResourceModifier.new

    modifier += @government.job_empire_attribute_modifiers(job) unless @government.nil?

    @edicts.each do |edict|
      modifier += edict.job_empire_attribute_modifiers(job)
    end

    @civics.filter { |c| c.is_a?(Modifier) }.each do |civic|
      modifier += civic.job_empire_attribute_modifiers(job)
    end

    @technologies.each { |t| modifier += t.job_empire_attribute_modifiers(job) }
    @traditions.each { |t| modifier += t.job_empire_attribute_modifiers(job) }

    modifier
  end

  def job_amenities_output_modifier(job)
    modifier = 0

    modifier += @government.job_amenities_output_modifier(job) unless @government.nil?

    @edicts.each do |edict|
      modifier += edict.job_stability_modifier(job)
    end

    @civics.filter { |c| c.is_a?(Modifier) }.each do |civic|
      modifier += civic.job_amenities_output_modifier(job)
    end

    @technologies.each { |t| modifier += t.job_amenities_output_modifier(job) }
    @traditions.each { |t| modifier += t.job_amenities_output_modifier(job) }

    modifier
  end

  def job_stability_modifier(job)
    modifier = 0

    modifier += @government.job_stability_modifier(job) unless @government.nil?

    @edicts.each do |edict|
      modifier += edict.job_stability_modifier(job)
    end

    @civics.filter { |c| c.is_a?(Modifier) }.each do |civic|
      modifier += civic.job_stability_modifier(job)
    end

    @technologies.each { |t| modifier += t.job_stability_modifier(job) }
    @traditions.each { |t| modifier += t.job_stability_modifier(job) }

    modifier
  end

  def job_worker_housing_modifier(job)
    modifier = ResourceModifier.new

    modifier += @government.job_worker_housing_modifier(job) unless @government.nil?

    @edicts.each do |edict|
      modifier += edict.job_worker_housing_modifier(job)
    end

    @civics.filter { |c| c.is_a?(Modifier) }.each do |civic|
      modifier += civic.job_worker_housing_modifier(job)
    end

    @technologies.each { |t| modifier += t.job_worker_housing_modifier(job) }
    @traditions.each { |t| modifier += t.job_worker_housing_modifier(job) }

    modifier
  end

  def colony_attribute_modifiers
    modifier = ResourceModifier.new({})
    modifier += @ruler.colony_attribute_modifiers
    modifier += @government.colony_attribute_modifiers(job) unless @government.nil?

    @edicts.each do |edict|
      modifier += edict.colony_attribute_modifiers(job)
    end

    @civics.filter { |c| c.is_a?(Modifier) }.each do |civic|
      modifier += civic.colony_attribute_modifiers(job)
    end

    @technologies.each { |t| modifier += t.colony_attribute_modifiers(job) }
    @traditions.each { |t| modifier += t.colony_attribute_modifiers(job) }

    modifier
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

  def output
    sector_output = @sectors.reduce(ResourceGroup.new) do |sum, sector|
      sum + sector.output
    end

    station_output = @stations.reduce(ResourceGroup.new) do |sum, station|
      sum + station.output
    end

    trade_deal_output = @trade_deals.reduce(ResourceGroup.new) do |sum, deal|
      sum + deal.output
    end

    sector_output + station_output + trade_deal_output +
      empire_base_modified_output
  end

  def upkeep
    sector_upkeep = @sectors.reduce(ResourceGroup.new) do |sum, sector|
      sum + sector.upkeep
    end

    station_upkeep = @stations.reduce(ResourceGroup.new) do |sum, station|
      sum + station.upkeep
    end

    trade_deal_upkeep = @trade_deals.reduce(ResourceGroup.new) do |sum, deal|
      sum + deal.upkeep
    end

    sector_upkeep + station_upkeep + trade_deal_upkeep
  end
end
