#!/usr/bin/env ruby

require './stellaris/lib/stellaris'

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
    net = output().dup

    upkeep().each do |good, value|
      if net.key?(good)
        net[good] -= value
      else
        net[good] = 0 - value
      end
    end

    net
  end
end

class Pop
  include UsesAmenities, OutputsResources

  attr_reader :job

  def initialize(species:, colony:, job:)
    @species = species
    @colony = colony
    @job = job
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

  def amenities_upkeep
    1
  end

  def happiness
    happiness = 50
    happiness += 5 if @species[:living_standard] == :shared_burden

    happiness += @colony.pop_happiness_modifiers

    happiness.floor
  end

  def political_power
    1
  end

  def output
    base_output = {
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

    if @species[:living_standard] == :shared_burden
      base_output[:trade] += 0.25
    elsif @species[:living_standard] == :utopian_abundance
      base_output[:trade] += 0.5
    end

    if @job == :politician
      base_output[:unity] += 6
    elsif @job == :science_director
      base_output[:physics_research] += 6
      base_output[:society_research] += 6
      base_output[:engineering_research] += 6
      base_output[:unity] += 2
    elsif @job == :metallurgist
      base_output[:alloys] += 3
    elsif @job == :artisan
      base_output[:consumer_goods] += 6
    elsif @job == :colonist
      base_output[:food] += 1
    elsif @job == :entertainer
      base_output[:unity] += 1
    elsif @job == :researcher
      base_output[:physics_research] += 4
      base_output[:society_research] += 4
      base_output[:engineering_research] += 4
    elsif @job == :bureaucrat
      base_output[:unity] += 4
    elsif @job == :clerk
      base_output[:trade] += 4
    elsif @job == :technician
      base_output[:energy] += 6
    elsif @job == :miner
      base_output[:minerals] += 4
    elsif @job == :farmer
      base_output[:food] += 6
    end

    multipliers = {
      food: 1,
      minerals: 1,
      energy: 1,
      consumer_goods: 1,
      alloys: 1,
      volatile_motes: 1,
      exotic_gases: 1,
      rare_crystals: 1,
      unity: 1,
      physics_research: 1,
      society_research: 1,
      engineering_research: 1,
      trade: 1,
    }

    if @species[:traits].include?(:void_dweller)
      multipliers.each_key do |good|
        multipliers[good] += 0.15 unless good == :trade
      end
    end

    if @species[:traits].include?(:intelligent)
      multipliers[:physics_research] += 0.1
      multipliers[:society_research] += 0.1
      multipliers[:engineering_research] += 0.1
    end

    if @species[:traits].include?(:natural_engineers)
      multipliers[:engineering_research] += 0.15
    end

    colony_modifiers = @colony.pop_output_modifiers(self)
    colony_modifiers[:additive].each do |good, value|
      base_output[good] += value
    end
    colony_modifiers[:multiplicative].each do |good, value|
      multipliers[good] += value
    end

    output = {}
    base_output.each_key do |good|
      output[good] = base_output[good] * multipliers[good]
    end

    output
  end

  def upkeep
    base_upkeep = {
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

    if @job == :politician or @job == :science_director or @job == :researcher or @job == :bureaucrat
      base_upkeep[:consumer_goods] += 2
    elsif @job == :metallurgist or @job == :artisan
      base_upkeep[:minerals] += 6
    elsif @job == :entertainer
      base_upkeep[:consumer_goods] += 1
    end

    multipliers = {
      food: 1,
      minerals: 1,
      energy: 1,
      consumer_goods: 1,
      alloys: 1,
      volatile_motes: 1,
      exotic_gases: 1,
      rare_crystals: 1,
      unity: 1,
      physics_research: 1,
      society_research: 1,
      engineering_research: 1,
      trade: 1,
    }

    colony_modifiers = @colony.pop_upkeep_modifiers(self)
    colony_modifiers[:additive].each do |good, value|
      base_upkeep[good] += value
    end
    colony_modifiers[:multiplicative].each do |good, value|
      multipliers[good] += value
    end

    upkeep = {}
    base_upkeep.each_key do |good|
      upkeep[good] = base_upkeep[good] * multipliers[good]
    end

    # Pop upkeep
    if @species[:living_standard] == :shared_burden
      upkeep[:consumer_goods] += 0.4
    elsif @species[:living_standard] == :utopian_abundance
      upkeep[:consumer_goods] += 1
    end
    upkeep[:food] += 1

    upkeep
  end
end

class Colony
  include UsesAmenities, OutputsResources

  attr_reader :pops

  def initialize(type:, size:, empire:, species:, leader: nil, designation: nil, districts: {}, buildings: {}, jobs: {}, deposits: {}, fill_jobs: false)
    @type = type
    @size = size
    @empire = empire
    @species = species
    @leader = leader
    @designation = designation
    @districts = districts.dup
    @buildings = buildings.dup
    @deposits = deposits.dup

    if fill_jobs
      @jobs = max_jobs()
    else
      @jobs = jobs.dup
    end

    @pops = []
    @jobs.each do |job, num|
      1.upto(num) do |x|
        @pops << Pop.new(species: @species, colony: self, job: job)
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
      @empire[:civics].include?(:shared_burdens) ? 5 : 0,
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

  def pop_output_modifiers(pop)
    adders = {
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

    multipliers = {
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

    multipliers.each_key do |good|
      multipliers[good] += stability_coefficient()
    end

    if @leader
      multipliers.each_key do |good|
        multipliers[good] += 0.02 * @leader[:level] unless good == :trade
      end

      if @leader[:traits].include?(:unifier)
        if pop.job == :bureaucrat
          multipliers[:unity] += 0.1
        end
      end
    end

    if @empire[:ethics].include?(:fanatic_egalitarian) and pop.specialist?
      multipliers.each_key do |good|
        multipliers[good] += 0.1 unless good == :trade
      end
    end

    if @empire[:ethics].include?(:xenophile)
      multipliers[:trade] += 0.1
    end

    if @empire[:civics].include?(:meritocracy) and pop.specialist?
      multipliers.each_key do |good|
        multipliers[good] += 0.1 unless good == :trade
      end
    end

    if @empire[:civics].include?(:beacon_of_liberty)
      multipliers[:unity] += 0.15
    end

    if @empire[:ruler][:traits].include?(:industrialist)
      multipliers[:minerals] += 0.1
    end

    if @empire[:technology][:society].include?(:eco_simulation)
      if pop.job == :farmer
        multipliers[:food] += 0.2
      end
    end

    if @designation == :empire_capital
      multipliers.each_key do |good|
        multipliers[good] += 0.1 unless good == :trade
      end
    elsif @designation == :research_station
      multipliers[:physics_research] += 0.1
      multipliers[:society_research] += 0.1
      multipliers[:engineering_research] += 0.1
    elsif @designation == :refinery_station
      if pop.job == :chemist or
        pop.job == :translucer or
        pop.job == :gas_refiner
        multipliers[:exotic_gases] += 0.1
        multipliers[:rare_crystals] += 0.1
        multipliers[:volatile_motes] += 0.1
      end
    elsif @designation == :unification_station
      if pop.job == :bureaucrat
        multipliers.each_key do |good|
          multipliers[good] += 0.1 unless good == :trade
        end
      end
    elsif @designation == :trade_station
      multipliers[:trade] += 0.2
    elsif @designation == :generator_station
      if pop.job == :technician
        multipliers[:energy] += 0.1
      end
    elsif @designation == :mining_station
      if pop.job == :miner
        multipliers[:minerals] += 0.1
        multipliers[:exotic_gases] += 0.1
        multipliers[:rare_crystals] += 0.1
        multipliers[:volatile_motes] += 0.1
      end
    end

    {
      additive: adders,
      multiplicative: multipliers,
    }
  end

  def pop_upkeep_modifiers(pop)
    adders = {
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

    multipliers = {
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

    if @designation == :foundry_station
      if pop.job == :metallurgist
        multipliers.each_key do |good|
          multipliers[good] -= 0.2 unless good == :trade
        end
      end
    elsif @designation == :factory_station
      if pop.job == :artisan or pop.job == :artificer
        multipliers.each_key do |good|
          multipliers[good] -= 0.2 unless good == :trade
        end
      end
    elsif @designation == :industrial_station
      if pop.job == :artisan or pop.job == :artificer or pop.job == :metallurgist
        multipliers.each_key do |good|
          multipliers[good] -= 0.1 unless good == :trade
        end
      end
    elsif @designation == :unification_station
      if pop.job == :bureaucrat
        multipliers.each_key do |good|
          multipliers[good] -= 0.1 unless good == :trade
        end
      end
    end

    {
      additive: adders,
      multiplicative: multipliers,
    }
  end

  def pop_upkeep(num, job)
    base_upkeep = {
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

    if job == :politician or job == :science_director or job == :researcher or job == :bureaucrat
      base_upkeep[:consumer_goods] += 2 * num
    elsif job == :metallurgist or job == :artisan
      base_upkeep[:minerals] += 6 * num
    elsif job == :entertainer
      base_upkeep[:consumer_goods] += 1 * num
    end

    multipliers = {
      food: 1,
      minerals: 1,
      energy: 1,
      consumer_goods: 1,
      alloys: 1,
      volatile_motes: 1,
      exotic_gases: 1,
      rare_crystals: 1,
      unity: 1,
      physics_research: 1,
      society_research: 1,
      engineering_research: 1,
      trade: 1,
    }

    if @designation == :foundry_station
      if job == :metallurgist
        multipliers.each_key do |good|
          multipliers[good] -= 0.2 unless good == :trade
        end
      end
    elsif @designation == :factory_station
      if job == :artisan or job == :artificer
        multipliers.each_key do |good|
          multipliers[good] -= 0.2 unless good == :trade
        end
      end
    elsif @designation == :industrial_station
      if job == :artisan or job == :artificer or job == :metallurgist
        multipliers.each_key do |good|
          multipliers[good] -= 0.1 unless good == :trade
        end
      end
    elsif @designation == :unification_station
      if job == :bureaucrat
        multipliers.each_key do |good|
          multipliers[good] -= 0.1 unless good == :trade
        end
      end
    end

    upkeep = {}
    base_upkeep.each_key do |good|
      upkeep[good] = base_upkeep[good] * multipliers[good]
    end

    # Pop upkeep
    if @species[:living_standard] == :shared_burden
      upkeep[:consumer_goods] += 0.4 * num
    elsif @species[:living_standard] == :utopian_abundance
      upkeep[:consumer_goods] += 1 * num
    end
    upkeep[:food] += 1 * num

    upkeep
  end

  def building_output(num, building)
    base_output = {
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

    multipliers = {
      food: 1,
      minerals: 1,
      energy: 1,
      consumer_goods: 1,
      alloys: 1,
      volatile_motes: 1,
      exotic_gases: 1,
      rare_crystals: 1,
      unity: 1,
      physics_research: 1,
      society_research: 1,
      engineering_research: 1,
      trade: 1,
    }

    output = {}
    base_output.each_key do |good|
      output[good] = base_output[good] * multipliers[good]
    end

    output
  end

  def building_upkeep(num, building)
    base_upkeep = {
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

    if building == :habitat_central_control or building == :habitat_administration
      base_upkeep[:energy] += 3 * num
      base_upkeep[:alloys] += 5 * num
    elsif building == :research_labs or building == :administrative_offices or
      building == :holo_theatres or building == :hydroponics_farms or
      building == :luxury_residences or building == :communal_housing or
      building == :energy_grid or building == :mineral_purification_plants or
      building == :food_processing_facilities or building == :alloy_foundries or
      building == :civilian_industries
      base_upkeep[:energy] += 2 * num
    end

    multipliers = {
      food: 1,
      minerals: 1,
      energy: 1,
      consumer_goods: 1,
      alloys: 1,
      volatile_motes: 1,
      exotic_gases: 1,
      rare_crystals: 1,
      unity: 1,
      physics_research: 1,
      society_research: 1,
      engineering_research: 1,
      trade: 1,
    }

    upkeep = {}
    base_upkeep.each_key do |good|
      upkeep[good] = base_upkeep[good] * multipliers[good]
    end

    upkeep
  end

  def output()
    output = {
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

    @pops.each do |pop|
      pop.output.each do |good, value|
        output[good] += value
      end
    end

    @buildings.each do |building, num|
      building_output(num, building).each do |good, value|
        output[good] += value
      end
    end

    @deposits.each do |good, value|
      output[good] += value
    end

    output
  end

  def upkeep()
    upkeep = {
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

    @pops.each do |pop|
      pop.upkeep.each do |good, value|
        upkeep[good] += value
      end
    end

    upkeep[:energy] += 2 * [
      districts(:habitation),
      districts(:industrial),
      districts(:trade),
      districts(:reactor),
      districts(:leisure),
      districts(:research),
      districts(:mining),
    ].reduce(0, &:+)

    @buildings.each do |building, num|
      building_upkeep(num, building).each do |good, value|
        upkeep[good] += value
      end
    end

    upkeep
  end
end

ruler = {
  level: 2,
  traits: [],
}

empire = {
  ruler: ruler,
  ethics: [:fanatic_egalitarian, :xenophile],
  civics: [:beacon_of_liberty, :shared_burdens],
  technology: {
    society: [
      :eco_simulation,
    ]
  },
}

species = {
  traits: [
    :void_dweller,
    :intelligent,
    :natural_engineers,
    :rapid_breeders,
    :deviants,
    :nonadaptive
  ],
  living_standard: :shared_burden,
}
governor = {
  level: 1,
  traits: [:resilient],
}

=begin
pandora = Colony.new(
  type: :habitat,
  designation: :empire_capital,
  size: 6,
  empire: empire,
  species: species,
  leader: governor,
  districts: {
    habitation: 1,
    industrial: 2,
    research: 1,
  },
  buildings: {
    habitat_central_control: 1,
    administrative_offices: 1,
    holo_theatres: 1,
    alloy_foundries: 0,
  },
  jobs: {
    politician: 2,
    researcher: 0,
    enforcer: 1,
    entertainer: 1,
    bureaucrat: 2,
    metallurgist: 2,
    artisan: 2,
  },
  deposits: {
    energy: 20,
    minerals: 20,
    food: 10,
    physics_research: 10,
    society_research: 10,
    engineering_research: 10,
    unity: 5,
    consumer_goods: 10 + 4,
    alloys: 5 + 12,
  }
)

aegle = Colony.new(
  type: :habitat,
  designation: :mining_station,
  size: 4,
  empire: empire,
  species: species,
  leader: governor,
  districts: {
    habitation: 1,
    trade: 1,
    mining: 1,
  },
  buildings: {
    habitat_administration: 1,
    hydroponics_farms: 1,
  },
  jobs: {
    colonist: 2,
    clerk: 1,
    miner: 3,
    farmer: 3,
  },
)

erytheis = Colony.new(
  type: :habitat,
  designation: :generator_station,
  size: 4,
  empire: empire,
  species: species,
  leader: governor,
  districts: {
    habitation: 1,
    trade: 1,
    reactor: 1,
  },
  buildings: {
    habitat_administration: 1,
    hydroponics_farms: 1,
  },
  jobs: {
    colonist: 2,
    clerk: 1,
    technician: 3,
    farmer: 3,
  },
)
=end

pandora = Colony.new(
  type: :habitat,
  designation: :empire_capital,
  size: 6,
  empire: empire,
  species: species,
  leader: governor,
  districts: {
    habitation: 1,
    industrial: 2,
    research: 3,
  },
  buildings: {
    habitat_central_control: 1,
    administrative_offices: 1,
    holo_theatres: 1,
    civilian_industries: 1,
  },
  fill_jobs: true,
  deposits: {
    energy: 20,
    minerals: 20,
    food: 10,
    physics_research: 10,
    society_research: 10,
    engineering_research: 10,
    unity: 5,
    consumer_goods: 10 + 4,
    alloys: 5 + 12,
  }
)

aegle = Colony.new(
  type: :habitat,
  designation: :mining_station,
  size: 4,
  empire: empire,
  species: species,
  leader: governor,
  districts: {
    habitation: 2,
    mining: 2,
  },
  buildings: {
    habitat_central_control: 1,
    hydroponics_farms: 1,
    civilian_industries: 1,
    holo_theatres: 1,
  },
  fill_jobs: true
)

erytheis = Colony.new(
  type: :habitat,
  designation: :generator_station,
  size: 4,
  empire: empire,
  species: species,
  leader: governor,
  districts: {
    habitation: 2,
    reactor: 2,
  },
  buildings: {
    habitat_central_control: 1,
    hydroponics_farms: 1,
    alloy_foundries: 1,
    holo_theatres: 1,
  },
  fill_jobs: true
)

hesperia = Colony.new(
  type: :habitat,
  designation: :generator_station,
  size: 4,
  empire: empire,
  species: species,
  leader: governor,
  districts: {
    habitation: 2,
    reactor: 2,
  },
  buildings: {
    habitat_central_control: 1,
    alloy_foundries: 1,
    holo_theatres: 1,
  },
  fill_jobs: true
)

arethusa = Colony.new(
  type: :habitat,
  designation: :factory_station,
  size: 4,
  empire: empire,
  species: species,
  leader: governor,
  districts: {
    habitation: 2,
    industrial: 2,
  },
  buildings: {
    habitat_central_control: 1,
    alloy_foundries: 1,
    civilian_industries: 1,
    holo_theatres: 1,
  },
  fill_jobs: true
)

hestia = Colony.new(
  type: :habitat,
  designation: :mining_station,
  size: 4,
  empire: empire,
  species: species,
  leader: governor,
  districts: {
    habitation: 2,
    mining: 2,
  },
  buildings: {
    habitat_central_control: 1,
    alloy_foundries: 1,
    holo_theatres: 1,
  },
  fill_jobs: true
)

medusa = Colony.new(
  type: :habitat,
  designation: :foundry_station,
  size: 4,
  empire: empire,
  species: species,
  leader: governor,
  districts: {
    habitation: 2,
    industrial: 2,
  },
  buildings: {
    habitat_central_control: 1,
    alloy_foundries: 1,
    civilian_industries: 1,
    holo_theatres: 1,
  },
  fill_jobs: true
)

aerica = Colony.new(
  type: :habitat,
  designation: :factory_station,
  size: 4,
  empire: empire,
  species: species,
  leader: governor,
  districts: {
    habitation: 2,
    research: 2,
  },
  buildings: {
    habitat_central_control: 1,
    alloy_foundries: 1,
    holo_theatres: 1,
  },
  fill_jobs: true
)

hippolyte = Colony.new(
  type: :habitat,
  designation: :mining_station,
  size: 4,
  empire: empire,
  species: species,
  leader: governor,
  districts: {
    habitation: 2,
    mining: 2,
  },
  buildings: {
    habitat_central_control: 1,
    alloy_foundries: 1,
    holo_theatres: 1,
  },
  fill_jobs: true
)

mapsaura = Colony.new(
  type: :habitat,
  designation: :unification_station,
  size: 4,
  empire: empire,
  species: species,
  leader: governor,
  districts: {
    habitation: 3,
    leisure: 1,
  },
  buildings: {
    habitat_central_control: 1,
    administrative_offices: 4,
  },
  fill_jobs: true
)

thetis = Colony.new(
  type: :habitat,
  designation: :research_station,
  size: 4,
  empire: empire,
  species: species,
  leader: governor,
  districts: {
    habitation: 3,
    leisure: 1,
  },
  buildings: {
    habitat_central_control: 1,
    research_labs: 4,
  },
  fill_jobs: true
)


pp pandora.net_output
pp aegle.net_output
pp erytheis.net_output

pp 'Energy station'
pp hesperia.net_output
pp 'Mining station'
pp hestia.net_output
pp 'CG station'
pp arethusa.net_output
pp 'Alloy station'
pp medusa.net_output
pp 'Research station (district)'
pp aerica.net_output
pp 'Research station (building)'
pp thetis.net_output
pp 'Admin station'
pp mapsaura.net_output

=begin
pp aerica.pops

empire_output = {}
[pandora, aegle, erytheis, hesperia, arethusa, hestia, medusa, aerica, hippolyte].each do |planet|
  planet.net_output.each do |good, value|
    empire_output[good] ||= 0
    empire_output[good] += value
  end
end

pp empire_output
=end