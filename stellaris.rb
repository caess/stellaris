#!/usr/bin/env ruby

require './stellaris/lib/stellaris'

ruler = Leader.new(level: 2)

species = Species.new(
  traits: [
    :void_dweller,
    :intelligent,
    :natural_engineers,
    :rapid_breeders,
    :deviants,
    :nonadaptive
  ],
  living_standard: :shared_burden,
)

empire = Empire.new(
  ruler: ruler,
  founding_species: species,
  ethics: [:fanatic_egalitarian, :xenophile],
  civics: [:beacon_of_liberty, :shared_burdens],
  technology: {
    society: [
      :eco_simulation,
    ]
  }
)

governor = Leader.new(level: 1)

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
  fill_jobs_with: species,
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
  fill_jobs_with: species
)

erytheis = Colony.new(
  type: :habitat,
  designation: :generator_station,
  size: 4,
  empire: empire,
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
  fill_jobs_with: species
)

hesperia = Colony.new(
  type: :habitat,
  designation: :generator_station,
  size: 4,
  empire: empire,
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
  fill_jobs_with: species
)

arethusa = Colony.new(
  type: :habitat,
  designation: :factory_station,
  size: 4,
  empire: empire,
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
  fill_jobs_with: species
)

hestia = Colony.new(
  type: :habitat,
  designation: :mining_station,
  size: 4,
  empire: empire,
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
  fill_jobs_with: species
)

medusa = Colony.new(
  type: :habitat,
  designation: :foundry_station,
  size: 4,
  empire: empire,
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
  fill_jobs_with: species
)

aerica = Colony.new(
  type: :habitat,
  designation: :research_station,
  size: 4,
  empire: empire,
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
  fill_jobs_with: species
)

hippolyte = Colony.new(
  type: :habitat,
  designation: :mining_station,
  size: 4,
  empire: empire,
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
  fill_jobs_with: species
)

mapsaura = Colony.new(
  type: :habitat,
  designation: :unification_station,
  size: 4,
  empire: empire,
  leader: governor,
  districts: {
    habitation: 3,
    leisure: 1,
  },
  buildings: {
    habitat_central_control: 1,
    administrative_offices: 4,
  },
  fill_jobs_with: species
)

thetis = Colony.new(
  type: :habitat,
  designation: :research_station,
  size: 4,
  empire: empire,
  leader: governor,
  districts: {
    habitation: 3,
    leisure: 1,
  },
  buildings: {
    habitat_central_control: 1,
    research_labs: 4,
  },
  fill_jobs_with: species
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