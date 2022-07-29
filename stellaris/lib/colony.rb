require_relative './mixins'
require_relative './pop'
require_relative './resource_group'
require_relative './resource_modifier'

class Colony
  include UsesAmenities, OutputsResources

  attr_reader :pops

  def initialize(type:, size:, sector:, designation: nil, districts: {}, buildings: {}, jobs: {}, deposits: {}, fill_jobs_with: nil)
    @type = type
    @size = size
    @sector = sector
    @sector.add_colony(self)
    @designation = designation
    @districts = districts.dup
    @buildings = buildings.dup

    if !deposits.is_a?(Array)
      deposits = [deposits]
    end
    @deposits = deposits.map do |deposit|
      if deposit.is_a?(Hash)
        ResourceGroup.new(deposit)
      elsif deposit.is_a?(ResourceGroup)
        deposit
      else
        nil
      end
    end

    @pops = []
    if fill_jobs_with
      @jobs = max_jobs()

      @jobs.each do |job, num|
        1.upto(num) do |x|
          @pops << Pop.new(species: fill_jobs_with, colony: self, job: job)
        end
      end
    else
      jobs.each do |job, pops|
        pops.each do |species, count|
          1.upto(count) do
            @pops << Pop.new(species: species, colony: self, job: job)
          end
        end
      end
    end

    @num_pops = @pops.length
  end

  def buildings(type)
    (@buildings[type] || 0)
  end

  def districts(type)
    (@districts[type] || 0)
  end

  def jobs(job)
    @pops.filter {|pop| pop.has_job?(job)}.count
  end

  def all_jobs
    @jobs
  end

  def max_jobs()
    max_jobs = {
      politician: 2 * buildings(:habitat_central_control),
      enforcer: 1 * buildings(:habitat_central_control),
      artisan: 1 * districts(:industrial) + 2 * buildings(:civilian_industries),
      metallurgist: 1 * districts(:industrial) + 2 * buildings(:alloy_foundries),
      colonist: 2 * buildings(:habitat_administration),
      researcher: 3 * districts(:research) + 2 * buildings(:research_labs),
      bureaucrat: 2 * buildings(:administrative_offices),
      entertainer: 2 * buildings(:holo_theatres) + 3 * districts(:leisure),
      clerk: 4 * districts(:trade),
      technician: 3 * districts(:reactor),
      miner: 3 * districts(:mining),
      farmer: 3 * buildings(:hydroponics_farms),
    }

    if @designation == :factory_station
      max_jobs[:artisan] += 1 * districts(:industrial)
      max_jobs[:metallurgist] -= 1 * districts(:industrial)
    elsif @designation == :foundry_station
      max_jobs[:artisan] -= 1 * districts(:industrial)
      max_jobs[:metallurgist] += 1 * districts(:industrial)
    elsif @designation == :hydroponics_station
      max_jobs[:farmer] += 1 * districts(:habitation)
    end

    max_jobs
  end

  def amenities_output
    5 * buildings(:habitat_central_control) +
      3 * buildings(:habitat_administration) +
      ((@designation == :empire_capital) ? 10 : 0) +
      @pops.reduce(0) {|sum, pop| sum + pop.amenities_output}
  end

  def amenities_upkeep
    5 + @pops.reduce(0) {|sum, pop| sum + pop.amenities_upkeep}
  end

  def pop_happiness_modifiers
    modifier = 0
    modifier += 10 if @designation == :leisure_station

    if net_amenities() > 0
     modifier += [20, (20.0 * net_amenities() / amenities_upkeep())].min
    elsif net_amenities() < 0
      modifier += [-50, 100 * (2.0/3 * net_amenities() / amenities_upkeep())].max
    end

    modifier
  end

  def approval_rating()
    1.0 * @pops.reduce(0) do |sum, pop|
      sum + pop.happiness * pop.political_power
    end / @pops.reduce(0) {|sum, pop| sum + pop.political_power}
  end

  def stability()
    stability = [
      50,
      1 * jobs(:enforcer),
      @designation == :empire_capital ? 5 : 0,
      @sector.empire.civics.include?(:shared_burdens) ? 5 : 0,
    ].reduce(0, &:+)

    if approval_rating() > 50
      stability += (0.6 * (approval_rating() - 50)).floor()
    elsif approval_rating() < 50
      stability -= (50 - approval_rating()).floor()
    end

    stability
  end

  def stability_coefficient()
    if stability() > 50
      0.006 * (stability() - 50).floor()
    elsif stability() < 50
      -0.01 * (50 - stability()).floor()
    else
      0
    end
  end

  def stability_coefficient_modifier()
    ResourceModifier::multiplyAllProducedResources(stability_coefficient()) +
      ResourceModifier.new(trade: {multiplicative: stability_coefficient()})
  end

  def job_output_modifiers(job)
    modifier = ResourceModifier.new()

    modifier += stability_coefficient_modifier()
    modifier += @sector.job_output_modifiers(job)

    if @designation == :empire_capital
      modifier += ResourceModifier::multiplyAllProducedResources(0.1)
    elsif @designation == :research_station
      modifier += ResourceModifier.new({
        physics_research: {multiplicative: 0.1},
        society_research: {multiplicative: 0.1},
        engineering_research: {multiplicative: 0.1},
      })
    elsif @designation == :refinery_station
      if job.job == :chemist or
        job.job == :translucer or
        job.job == :gas_refiner
        modifier += ResourceModifier.new({
          exotic_gases: {multiplicative: 0.1},
          rare_crystals: {multiplicative: 0.1},
          volatile_motes: {multiplicative: 0.1},
        })
      end
    elsif @designation == :unification_station
      if job.job == :bureaucrat
        modifier += ResourceModifier::multiplyAllProducedResources(0.1)
      end
    elsif @designation == :trade_station
      modifier += ResourceModifier.new({trade: {multiplicative: 0.2}})
    elsif @designation == :generator_station
      if job.job == :technician
        modifier += ResourceModifier.new({energy: {multiplicative: 0.1}})
      end
    elsif @designation == :mining_station
      if job.job == :miner
        modifier += ResourceModifier.new({
          minerals: {multiplicative: 0.1},
          exotic_gases: {multiplicative: 0.1},
          rare_crystals: {multiplicative: 0.1},
          volatile_motes: {multiplicative: 0.1},
        })
      end
    end

    modifier
  end

  def pop_output_modifiers(pop)
    modifier = ResourceModifier.new()
    modifier += ResourceModifier.new({trade: {multiplicative: stability_coefficient()}})
    modifier += @sector.pop_output_modifiers(pop)

    if @designation == :trade_station
      modifier += ResourceModifier.new({trade: {multiplicative: 0.2}})
    end

    modifier
  end

  def job_upkeep_modifiers(job)
    modifier = ResourceModifier.new()

    if @designation == :foundry_station
      if job.job == :metallurgist
        modifier += ResourceModifier::multiplyAllProducedResources(-0.2)
      end
    elsif @designation == :factory_station
      if job.job == :artisan or job.job == :artificer
        modifier += ResourceModifier::multiplyAllProducedResources(-0.2)
      end
    elsif @designation == :industrial_station
      if job.job == :artisan or job.job == :artificer or job.job == :metallurgist
        modifier += ResourceModifier::multiplyAllProducedResources(-0.1)
      end
    elsif @designation == :unification_station
      if job.job == :bureaucrat
        modifier += ResourceModifier::multiplyAllProducedResources(-0.1)
      end
    end

    modifier
  end

  def pop_upkeep_modifiers(pop)
    ResourceModifier::NONE
  end

  def building_output(num, building)
    ResourceGroup.new()
  end

  def building_upkeep(num, building)
    upkeep = ResourceGroup.new()

    if building == :habitat_central_control or building == :habitat_administration
      upkeep[:energy] = 3 * num
      upkeep[:alloys] = 5 * num
    elsif building == :research_labs or building == :administrative_offices or
      building == :holo_theatres or building == :hydroponics_farms or
      building == :luxury_residences or building == :communal_housing or
      building == :energy_grid or building == :mineral_purification_plants or
      building == :food_processing_facilities or building == :alloy_foundries or
      building == :civilian_industries
      upkeep[:energy] = 2 * num
    end

    upkeep
  end

  def output()
    pop_output = @pops.reduce(ResourceGroup.new()) do |sum, pop|
      sum + pop.output
    end

    building_output = @buildings.reduce(ResourceGroup.new()) do |sum, (building, num)|
      sum + building_output(num, building)
    end

    deposits_output = @deposits.reduce(ResourceGroup.new()) do |sum, deposit|
      sum + deposit
    end

    pop_output + building_output + deposits_output
  end

  def upkeep()
    pop_upkeep = @pops.reduce(ResourceGroup.new()) do |sum, pop|
      sum + pop.upkeep
    end

    building_upkeep = @buildings.reduce(ResourceGroup.new()) do |sum, (building, num)|
      sum + building_upkeep(num, building)
    end

    district_upkeep = ResourceGroup.new({
      energy: 2 * [
        districts(:habitation),
        districts(:industrial),
        districts(:trade),
        districts(:reactor),
        districts(:leisure),
        districts(:research),
        districts(:mining),
      ].reduce(0, &:+)
    })

    pop_upkeep + building_upkeep + district_upkeep
  end
end
