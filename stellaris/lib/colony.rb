require_relative "./district"
require_relative "./job"
require_relative "./mixins"
require_relative "./pop"
require_relative "./resource_group"
require_relative "./resource_modifier"

class Colony
  include UsesAmenities, OutputsResources

  attr_reader :pops, :districts

  def initialize(
    type:, size:, sector:, designation: nil, districts: {}, buildings: {},
    decisions: {}, jobs: {}, deposits: {}, fill_jobs_with: nil
  )
    @type = type
    @size = size
    @sector = sector
    @sector.add_colony(self)
    @designation = designation
    @districts = districts.dup
    @buildings = buildings.dup
    @decisions = decisions.dup

    @districts = []
    districts.each do |type, number|
      if type == :habitation
        district = District::HabitationDistrict
      elsif type == :industrial
        district = District::HabitatIndustrialDistrict
      elsif type == :mining
        district = District::AstroMiningBay
      elsif type == :reactor
        district = District::ReactorDistrict
      elsif type == :research
        district = District::ResearchDistrict
      elsif type == :trade
        district = District::HabitatTradeDistrict
      elsif type == :leisure
        district = District::LeisureDistrict
      end

      1.upto(number) { |x| @districts << district }
    end

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

      @jobs.each do |job_id, num|
        job = Job::lookup(job_id)

        1.upto(num) do |x|
          @pops << Pop.new(species: fill_jobs_with, colony: self, job: job)
        end
      end
    else
      jobs.each do |job_id, pops|
        job = Job::lookup(job_id)

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

  def num_districts(type)
    @districts.find_all { |d| d == type }.count
  end

  def jobs(job)
    @pops.filter { |pop| pop.has_job?(job) }.count
  end

  def all_jobs
    @jobs
  end

  def max_jobs()
    max_jobs = @districts.reduce({}) { |sum, x| sum.merge(x.max_jobs) { |k, v1, v2| v1 + v2 } }
    max_jobs = max_jobs.merge({
      Job::Politician => 2 * buildings(:habitat_central_control),
      Job::Enforcer => 1 * buildings(:habitat_central_control),
      Job::Artisan => 2 * buildings(:civilian_industries),
      Job::Metallurgist => 2 * buildings(:alloy_foundries),
      Job::Colonist => 2 * buildings(:habitat_administration),
      Job::Researcher => 2 * buildings(:research_labs),
      Job::Bureaucrat => 2 * buildings(:administrative_offices),
      Job::Entertainer => 2 * buildings(:holo_theatres),
      Job::Farmer => 3 * buildings(:hydroponics_farms),
    }) { |k, v1, v2| v1 + v2 }

    if @designation == :factory_station
      max_jobs[Job::Artisan] += 1 * num_districts(District::HabitatIndustrialDistrict)
      max_jobs[Job::Metallurgist] -= 1 * num_districts(District::HabitatIndustrialDistrict)
    elsif @designation == :foundry_station
      max_jobs[Job::Artisan] -= 1 * num_districts(District::HabitatIndustrialDistrict)
      max_jobs[Job::Metallurgist] += 1 * num_districts(District::HabitatIndustrialDistrict)
    elsif @designation == :hydroponics_station
      max_jobs[Job::Farmer] += 1 * num_districts(District::HabitationDistrict)
    end

    max_jobs
  end

  def buildings_amenities_output
    5 * buildings(:habitat_central_control) +
      3 * buildings(:habitat_administration)
  end

  def designation_amenities_output
    @designation == :empire_capital ? 10 : 0
  end

  def amenities_output
    buildings_amenities_output + designation_amenities_output +
      @pops.reduce(0) { |sum, pop| sum + pop.amenities_output }
  end

  def amenities_upkeep
    5 + @pops.reduce(0) { |sum, pop| sum + pop.amenities_upkeep }
  end

  def pop_happiness_modifiers
    modifier = 0
    modifier += 10 if @designation == :leisure_station
    modifier += @pops.reduce(0) { |sum, pop| sum + pop.pop_happiness_modifiers }

    if net_amenities() > 0
      modifier += [20, (20.0 * net_amenities() / amenities_upkeep())].min
    elsif net_amenities() < 0
      modifier += [-50, 100 * (2.0 / 3 * net_amenities() / amenities_upkeep())].max
    end

    modifier
  end

  def approval_rating()
    1.0 * @pops.reduce(0) do |sum, pop|
      sum + pop.happiness * pop.political_power
    end / @pops.reduce(0) { |sum, pop| sum + pop.political_power }
  end

  def stability_modifier()
    @designation == :empire_capital ? 5 : 0
  end

  def stability()
    stability = [
      50,
      @pops.reduce(0) { |sum, pop| sum + pop.stability_modifier },
      @sector.stability_modifier,
      stability_modifier,
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
      ResourceModifier.new(trade: { multiplicative: stability_coefficient() })
  end

  def job_output_modifiers(job)
    modifier = ResourceModifier.new()

    @pops.each { |pop| modifier += pop.all_job_output_modifiers(job) }

    modifier += stability_coefficient_modifier()
    modifier += @sector.job_output_modifiers(job)

    @decisions.each { |d| modifier += d.job_output_modifiers(job) }

    if @designation == :empire_capital
      modifier += ResourceModifier::multiplyAllProducedResources(0.1)
    elsif @designation == :research_station
      modifier += ResourceModifier.new({
        physics_research: { multiplicative: 0.1 },
        society_research: { multiplicative: 0.1 },
        engineering_research: { multiplicative: 0.1 },
      })
    elsif @designation == :refinery_station
      if job.chemist? or job.translucer? or job.refiner?
        modifier += ResourceModifier.new({
          exotic_gases: { multiplicative: 0.1 },
          rare_crystals: { multiplicative: 0.1 },
          volatile_motes: { multiplicative: 0.1 },
        })
      end
    elsif @designation == :unification_station
      if job.administrator?
        modifier += ResourceModifier::multiplyAllProducedResources(0.1)
      end
    elsif @designation == :trade_station
      modifier += ResourceModifier.new({ trade: { multiplicative: 0.2 } })
    elsif @designation == :generator_station
      if job.technician?
        modifier += ResourceModifier.new({ energy: { multiplicative: 0.1 } })
      end
    elsif @designation == :mining_station
      if job.miner?
        modifier += ResourceModifier.new({
          minerals: { multiplicative: 0.1 },
          exotic_gases: { multiplicative: 0.1 },
          rare_crystals: { multiplicative: 0.1 },
          volatile_motes: { multiplicative: 0.1 },
        })
      end
    end

    modifier
  end

  def pop_output_modifiers(pop)
    modifier = ResourceModifier.new()
    modifier += ResourceModifier.new({ trade: { multiplicative: stability_coefficient() } })
    modifier += @sector.pop_output_modifiers(pop)

    if @designation == :trade_station
      modifier += ResourceModifier.new({ trade: { multiplicative: 0.2 } })
    end

    modifier
  end

  def job_upkeep_modifiers(job)
    modifier = ResourceModifier.new()

    @decisions.each { |d| modifier += d.job_upkeep_modifiers(job) }

    if @designation == :foundry_station
      if job.metallurgist?
        modifier += ResourceModifier::multiplyAllProducedResources(-0.2)
      end
    elsif @designation == :factory_station
      if job.artisan?
        modifier += ResourceModifier::multiplyAllProducedResources(-0.2)
      end
    elsif @designation == :industrial_station
      if job.artisan? or job.metallurgist?
        modifier += ResourceModifier::multiplyAllProducedResources(-0.1)
      end
    elsif @designation == :unification_station
      if job.administrator?
        modifier += ResourceModifier::multiplyAllProducedResources(-0.1)
      end
    end

    modifier += @sector.job_upkeep_modifiers(job)

    modifier
  end

  def pop_upkeep_modifiers(pop)
    ResourceModifier::NONE
  end

  def job_colony_attribute_modifiers(job)
    modifier = ResourceModifier::NONE

    modifier += @sector.job_colony_attribute_modifiers(job) unless @sector.nil?

    @decisions.each { |d| modifier += d.job_colony_attribute_modifiers(job) }

    modifier
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

    district_upkeep = @districts.reduce(ResourceGroup.new({})) do |sum, d|
      sum + d.upkeep
    end

    pop_upkeep + building_upkeep + district_upkeep
  end
end
