class ResourceModifier
  attr_reader :values

  def initialize(values = {})
    @values = values.dup
  end

  def +(rhs)
    result = @values.dup

    rhs.values.each_key do |resource|
      if result.key?(resource)
        rhs.values[resource].each do |modifier_type, value|
          result[resource][modifier_type] ||= 0
          result[resource][modifier_type] += value
        end
      else
        result[resource] = rhs.values[resource]
      end
    end

    return ResourceModifier.new(result)
  end

  def ==(obj)
    @values == obj.values
  end

  NONE = ResourceModifier.new()

  def self.multiplyAllProducedResources(value)
    resources = {}
    ResourceGroup::PRODUCED_RESOURCES.each do |resource|
      resources[resource] = {multiplicative: value}
    end

    return ResourceModifier.new(resources)
  end
end

class ResourceGroup
  PRODUCED_RESOURCES = [
    :food, :minerals, :energy, :consumer_goods, :alloys, :volatile_motes,
    :exotic_gases, :rare_crystals, :unity, :physics_research,
    :society_research, :engineering_research,
  ]

  def initialize(resources = {})
    @resources = {
      food: 0,
      minerals: 0,
      energy: 0,
      consumer_goods: 0,
      alloys: 0,
      volatile_motes: 0,
      exotic_gases: 0,
      rare_crystals: 0,
      unity: 0,
      physics_research: 0,
      society_research: 0,
      engineering_research: 0,
      trade: 0,
    }

    resources.each do |good, value|
      @resources[good] = value
    end

    @modifiers = []
    @resolved = nil
  end

  def [](key)
    return nil if !@resources.key?(key)

    resolve if @resolved.nil?

    return @resolved[key]
  end

  def []=(key, value)
    return nil if !@resources.key?(key)

    @resources[key] = value
  end

  def <<(modifier)
    @modifiers << modifier
    @resolved = nil
  end

  def resolve()
    return @resolved.dup if !@resolved.nil?

    @resolved = @resources.dup
    total_modifiers = @modifiers.reduce(ResourceModifier::NONE, &:+)

    total_modifiers.values.each do |good, modifiers|
      @resolved[good] += (modifiers[:additive] || 0)
      @resolved[good] *= 1 + (modifiers[:multiplicative] || 0)
    end

    return @resolved.dup
  end

  def +(rhs)
    output = resolve().dup

    rhs.resolve().each do |good, value|
      output[good] += value
    end

    return ResourceGroup.new(output)
  end

  def -(rhs)
    output = resolve().dup

    rhs.resolve().each do |good, value|
      output[good] -= value
    end

    return ResourceGroup.new(output)
  end
end

module UsesAmenities
  def amenities_output
    0
  end

  def amenities_upkeep
    0
  end

  def net_amenities
    amenities_output - amenities_upkeep
  end
end

module OutputsResources
  def output
    {}
  end

  def upkeep
    {}
  end

  def net_output
    output() - upkeep()
  end
end

class Job
  include UsesAmenities, OutputsResources

  attr_reader :job, :worker

  def initialize(job:, worker:)
    @job = job
    @worker = worker
  end

  def specialist?
    [
      :metallurgist, :catalytic_technician, :artisan, :artificer,
      :pearl_diver, :chemist, :gas_refiner, :translucer, :colonist,
      :roboticist, :medical_worker, :entertainer, :duelist, :enforcer,
      :telepath, :necromancer, :reassigner, :necrophyte, :researcher,
      :bureaucrat, :manager, :priest, :death_priest, :death_chronicler,
      :culture_worker,
    ].include?(@job)
  end

  def amenities_output
    if @job == :politician or @job == :science_director or @job == :colonist
      3
    elsif @job == :entertainer
      10
    elsif @job == :clerk
      2
    else
      0
    end
  end

  def output
    output = ResourceGroup.new()

    if @job == :politician
      output[:unity] = 6
    elsif @job == :science_director
      output[:physics_research] = 6
      output[:society_research] = 6
      output[:engineering_research] = 6
      output[:unity] = 2
    elsif @job == :metallurgist
      output[:alloys] = 3
    elsif @job == :artisan
      output[:consumer_goods] = 6
    elsif @job == :colonist
      output[:food] = 1
    elsif @job == :entertainer
      output[:unity] = 1
    elsif @job == :researcher
      output[:physics_research] = 4
      output[:society_research] = 4
      output[:engineering_research] = 4
    elsif @job == :bureaucrat
      output[:unity] = 4
    elsif @job == :clerk
      output[:trade] = 4
    elsif @job == :technician
      output[:energy] = 6
    elsif @job == :miner
      output[:minerals] = 4
    elsif @job == :farmer
      output[:food] = 6
    end

    output << @worker.job_output_modifiers(self)

    output
  end

  def upkeep
    upkeep = ResourceGroup.new()

    if @job == :politician or @job == :science_director or @job == :researcher or @job == :bureaucrat
      upkeep[:consumer_goods] = 2
    elsif @job == :metallurgist or @job == :artisan
      upkeep[:minerals] = 6
    elsif @job == :entertainer
      upkeep[:consumer_goods] = 1
    end

    upkeep << @worker.job_upkeep_modifiers(self)

    upkeep
  end
end

class Pop
  include UsesAmenities, OutputsResources

  attr_reader :job

  def initialize(species:, colony:, job:)
    @species = species
    @colony = colony
    @job = Job.new(job: job, worker: self)
  end

  def specialist?
    @job.specialist?
  end

  def amenities_output
    @job.amenities_output
  end

  def amenities_upkeep
    1
  end

  def happiness
    happiness = 50
    happiness += 5 if @species.living_standard == :shared_burden

    happiness += @colony.pop_happiness_modifiers

    happiness.floor
  end

  def political_power
    1
  end

  def job_output_modifiers(job)
    modifier = ResourceModifier::NONE

    modifier += @species.job_output_modifiers(job)
    modifier += @colony.job_output_modifiers(job)

    modifier
  end

  def job_upkeep_modifiers(job)
    modifier = ResourceModifier::NONE

    modifier += @colony.job_upkeep_modifiers(job)

    modifier
  end

  def pop_output
    output = ResourceGroup.new()

    if @species.living_standard == :shared_burden
      output[:trade] = 0.25
    elsif @species.living_standard == :utopian_abundance
      output[:trade] = 0.5
    end

    output << @colony.pop_output_modifiers(self)

    output
  end

  def pop_upkeep
    upkeep = ResourceGroup.new()

    if @species.living_standard == :shared_burden
      upkeep[:consumer_goods] = 0.4
    elsif @species.living_standard == :utopian_abundance
      upkeep[:consumer_goods] = 1
    end
    upkeep[:food] = 1

    upkeep << @colony.pop_upkeep_modifiers(self)

    upkeep
  end

  def output
    @job.output + pop_output
  end

  def upkeep
    @job.upkeep + pop_upkeep
  end
end

class Colony
  include UsesAmenities, OutputsResources

  attr_reader :pops

  def initialize(type:, size:, sector:, designation: nil, districts: {}, buildings: {}, jobs: {}, deposits: {}, fill_jobs_with: nil)
    @type = type
    @size = size
    @sector = sector
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

    if fill_jobs_with
      @jobs = max_jobs()

      @pops = []
      @jobs.each do |job, num|
        1.upto(num) do |x|
          @pops << Pop.new(species: fill_jobs_with, colony: self, job: job)
        end
      end
    else
      @jobs = jobs.dup
    end

    @num_pops = @pops.length
  end

  def buildings(type)
    (@buildings[type] || 0)
  end

  def districts(type)
    (@districts[type] || 0)
  end

  def jobs(type)
    (@jobs[type] || 0)
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

class Empire
  attr_reader :ruler, :ethics, :civics, :technology
  def initialize(founding_species:, ruler:, ethics: [], civics: [], technology: {})
    @ruler = ruler
    @ruler.role = :ruler
    @ethics = ethics.dup
    @civics = civics.dup
    @technology = technology.dup

    [:physics, :society, :engineering].each do |science|
      @technology[science] = [] unless @technology.key?(science)
    end
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
end

class Species
  attr_reader :traits, :living_standard

  def initialize(traits: [], living_standard:)
    @living_standard = living_standard
    @traits = traits.dup
  end

  def job_output_modifiers(job)
    modifier = ResourceModifier.new()

    if @traits.include?(:void_dweller)
      # FIXME - need to check planet type
      modifier += ResourceModifier::multiplyAllProducedResources(0.15)
    end

    if @traits.include?(:intelligent)
      modifier += ResourceModifier.new({
        physics_research: {multiplicative: 0.1},
        society_research: {multiplicative: 0.1},
        engineering_research: {multiplicative: 0.1},
      })
    end

    if @traits.include?(:natural_engineers)
      modifier += ResourceModifier.new({
        engineering_research: {multiplicative: 0.15},
      })
    end

    modifier
  end
end

class Leader
  attr_reader :level, :traits
  attr_accessor :role

  def initialize(level:, traits: [])
    @level = level
    @traits = traits.dup
    @role = nil
  end

  def governor?
    @role == :governor
  end

  def ruler?
    @role == :ruler
  end

  def job_output_modifiers(job)
    modifier = ResourceModifier.new()

    if governor?
      modifier += ResourceModifier::multiplyAllProducedResources(
        0.02 * @level
      )

      if @traits.include?(:unifier)
        if job.job == :bureaucrat
          modifier += ResourceModifier.new({unity: {multiplicative: 0.1}})
        end
      end
    elsif ruler?
      if @traits.include?(:industrialist)
        modifier += ResourceModifier.new(minerals: {multiplicative: 0.1})
      end
    end

    modifier
  end
end

class Sector
  attr_reader :empire, :governor

  def initialize(empire:, governor:)
    @empire = empire
    @governor = governor
    @governor.role = :governor
  end

  def job_output_modifiers(job)
    modifier = ResourceModifier.new()
    modifier += @governor.job_output_modifiers(job)
    modifier += @empire.job_output_modifiers(job)

    if @governor

    end

    modifier
  end

  def pop_output_modifiers(pop)
    modifier = ResourceModifier.new()
    modifier += @empire.pop_output_modifiers(pop)

    modifier
  end
end
