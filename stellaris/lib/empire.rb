require_relative './mixins'
require_relative './resource_group'
require_relative './resource_modifier'
require_relative './sector'

class Empire
  include OutputsResources

  attr_reader :ruler, :ethics, :civics, :technology

  def initialize(founding_species:, ruler:, ethics: [], civics: [], technology: {})
    @ruler = ruler
    @ruler.role = :ruler
    @ethics = ethics.dup
    @civics = civics.dup
    @technology = technology.dup

    @sectors = []

    [:physics, :society, :engineering].each do |science|
      @technology[science] = [] unless @technology.key?(science)
    end
  end

  def add_sector(sector)
    @sectors << sector
  end

  def job_output_modifiers(job)
    modifier = ResourceModifier.new()
    modifier += @ruler.job_output_modifiers(job)

    if @ethics.include?(:fanatic_egalitarian) and job.worker.specialist?
      modifier += ResourceModifier::multiplyAllProducedResources(0.1)
    end

    if @ethics.include?(:xenophile)
      modifier += ResourceModifier.new(trade: {multiplicative: 0.1})
    end

    if @civics.include?(:meritocracy) and job.worker.specialist?
      modifier += ResourceModifier::multiplyAllProducedResources(0.1)
    end

    if @civics.include?(:beacon_of_liberty)
      modifier += ResourceModifier.new(unity: {multiplicative: 0.15})
    end

    if @technology[:society].include?(:eco_simulation)
      if job.job.farmer?
        modifier += ResourceModifier.new(food: {multiplicative: 0.2})
      end
    end

    modifier
  end

  def pop_output_modifiers(pop)
    modifier = ResourceModifier.new()

    if @ethics.include?(:xenophile)
      modifier += ResourceModifier.new({trade: {multiplicative: 0.1}})
    end

    modifier
  end

  def stability_modifier
    modifier = 0

    if @civics.include?(:shared_burdens)
      modifier += 5
    end

    modifier
  end

  def empire_base_modifiers
    modifier = ResourceModifier.new()
    modifier += @ruler.empire_base_modifiers

    if @civics.include?(:beacon_of_liberty)
      modifier += ResourceModifier.new(unity: {multiplicative: 0.15})
    end

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
      alloys: 5,
    })

    empire_base << ResourceModifier.new({
      energy: {multiplicative: -1},
      minerals: {multiplicative: -1},
      food: {multiplicative: -1},
      physics_research: {multiplicative: -1},
      society_research: {multiplicative: -1},
      engineering_research: {multiplicative: -1},
      unity: {multiplicative: -1},
      consumer_goods: {multiplicative: -1},
      alloys: {multiplicative: -1},
    })

    empire_base << empire_base_modifiers()

    empire_base
  end

  def output
    @sectors.reduce(ResourceGroup.new()) do |sum, sector|
      sum + sector.output
    end + empire_base_modified_output
  end

  def upkeep
    @sectors.reduce(ResourceGroup.new()) do |sum, sector|
      sum + sector.upkeep
    end
  end
end
