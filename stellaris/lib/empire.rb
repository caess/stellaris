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
      if job.job == :farmer
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

  def output
    @sectors.reduce(ResourceGroup.new()) do |sum, sector|
      sum + sector.output
    end
  end

  def upkeep
    @sectors.reduce(ResourceGroup.new()) do |sum, sector|
      sum + sector.upkeep
    end
  end
end
