# frozen_string_literal: true

require_relative './job'
require_relative './resource_group'
require_relative './resource_modifier'

class Building
  attr_reader :name, :housing, :amenities_output, :colony_attribute_modifiers,
              :stability_modifier

  def initialize(name:, housing: 0, amenities_output: 0, max_jobs: {},
                 upkeep: {}, colony_attribute_modifiers: {},
                 job_output_modifiers: {}, stability_modifier: 0)
    @name = name
    @housing = housing
    @amenities_output = amenities_output
    @stability_modifier = stability_modifier
    @max_jobs = max_jobs.dup
    @upkeep = ResourceGroup.new(upkeep)
    @colony_attribute_modifiers = ResourceModifier.new(colony_attribute_modifiers)
    @job_output_modifiers = job_output_modifiers.dup
  end

  def max_jobs
    @max_jobs.dup
  end

  def upkeep
    @upkeep.dup
  end

  def job_output_modifiers(job)
    return ResourceModifier::NONE if job.nil?

    @job_output_modifiers.each do |key, modifier|
      if (key == job.job) ||
         (key.is_a?(Symbol) && job.respond_to?(key) && job.send(key)) ||
         (key.is_a?(Proc) && key.lambda? && key.call(job))
        return ResourceModifier.new(modifier)
      end
    end

    ResourceModifier::NONE
  end

  class Tier1Building < Building
    def initialize(name:, job:)
      super(
        name: name,
        max_jobs: { job => 2 },
        upkeep: { energy: 2 },
      )
    end
  end

  class Tier2Building < Building
    def initialize(name:, job:, strategic_resource:)
      super(
        name: name,
        max_jobs: { job => 4 },
        upkeep: {
          :energy => 5,
          strategic_resource => 1
        },
      )
    end
  end

  class Tier3Building < Building
    def initialize(name:, job:, strategic_resource:)
      super(
        name: name,
        max_jobs: { job => 6 },
        upkeep: {
          :energy => 8,
          strategic_resource => 2
        },
      )
    end
  end

  def self.tiered_buildings(
    tier1_name:, tier2_name:, job:, strategic_resource:, tier3_name: nil
  )
    buildings = [
      Building::Tier1Building.new(name: tier1_name, job: job),
      Building::Tier2Building.new(
        name: tier2_name, job: job, strategic_resource: strategic_resource
      )
    ]

    unless tier3_name.nil?
      buildings << Building::Tier3Building.new(
        name: tier3_name, job: job, strategic_resource: strategic_resource
      )
    end

    buildings
  end

  # Capital buildings
  ## Standard
  ReassembledShipShelter = Building.new(
    name: 'Reassembled Ship Shelter',
    housing: 3,
    amenities_output: 7,
    max_jobs: { Job::Colonist => 2 },
    upkeep: { energy: 1 },
    colony_attribute_modifiers: { building_slot: { additive: 1 } }
  )

  PlanetaryAdministration = Building.new(
    name: 'Planetary Administration',
    housing: 5,
    amenities_output: 5,
    max_jobs: {
      Job::Politician => 2,
      Job::Enforcer => 1
    },
    upkeep: { energy: 5 },
    colony_attribute_modifiers: {
      building_slot: { additive: 2 },
      branch_office_building_slot: { additive: 1 }
    }
  )

  PlanetaryCapital = Building.new(
    name: 'Planetary Capital',
    housing: 8,
    amenities_output: 8,
    max_jobs: {
      Job::Politician => 3,
      Job::Enforcer => 2
    },
    upkeep: { energy: 8 },
    colony_attribute_modifiers: {
      building_slot: { additive: 3 },
      branch_office_building_slot: { additive: 2 }
    }
  )

  SystemCapitalComplex = Building.new(
    name: 'System Capital-Complex',
    housing: 12,
    amenities_output: 12,
    max_jobs: {
      Job::Politician => 4,
      Job::Enforcer => 3
    },
    upkeep: { energy: 10 },
    colony_attribute_modifiers: {
      building_slot: { additive: 4 },
      branch_office_building_slot: { additive: 4 }
    }
  )

  ImperialPalace = Building.new(
    name: 'Imperial Palace',
    housing: 18,
    amenities_output: 18,
    max_jobs: {
      Job::Politician => 6,
      Job::Enforcer => 5
    },
    upkeep: { energy: 10 },
    colony_attribute_modifiers: {
      building_slot: { additive: 11 },
      branch_office_building_slot: { additive: 4 }
    }
  )

  ## Habitat
  HabitatAdministration = Building.new(
    name: 'Habitat Administration',
    housing: 3,
    amenities_output: 3,
    max_jobs: { Job::Politician => 1 },
    upkeep: {
      energy: 3,
      alloys: 5
    },
    colony_attribute_modifiers: {
      building_slot: { additive: 1 }
    }
  )

  HabitatCentralControl = Building.new(
    name: 'Habitat Central Control',
    housing: 5,
    amenities_output: 5,
    max_jobs: {
      Job::Politician => 2,
      Job::Enforcer => 1
    },
    upkeep: {
      energy: 3,
      alloys: 5
    },
    colony_attribute_modifiers: {
      building_slot: { additive: 2 },
      branch_office_building_slot: { additive: 1 }
    }
  )

  ResortAdministration = Building.new(
    name: 'Resort Administration',
    housing: 5,
    amenities_output: 5,
    max_jobs: {
      Job::Politician => 1,
      Job::Entertainer => 1
    },
    upkeep: { energy: 2 },
    colony_attribute_modifiers: {
      building_slot: { additive: 5 },
      branch_office_building_slot: { additive: 1 }
    }
  )

  ResortCapitalComplex = Building.new(
    name: 'Resort Capital-Complex',
    housing: 10,
    amenities_output: 10,
    max_jobs: {
      Job::Politician => 1,
      Job::Entertainer => 2
    },
    upkeep: { energy: 5 },
    colony_attribute_modifiers: {
      building_slot: { additive: 11 },
      branch_office_building_slot: { additive: 2 }
    }
  )

  GovernorsPalace = Building.new(
    name: "Governor's Palace",
    housing: 5,
    amenities_output: 5,
    stability_modifier: 5,
    max_jobs: {
      Job::Politician => 2,
      Job::Overseer => 2
    },
    upkeep: { energy: 2 },
    colony_attribute_modifiers: {
      building_slot: { additive: 5 },
      branch_office_building_slot: { additive: 1 }
    }
  )

  GovernorsEstates = Building.new(
    name: "Governor's Estates",
    housing: 10,
    amenities_output: 10,
    stability_modifier: 10,
    max_jobs: {
      Job::Politician => 2,
      Job::Overseer => 4
    },
    upkeep: { energy: 2 },
    colony_attribute_modifiers: {
      building_slot: { additive: 11 },
      branch_office_building_slot: { additive: 2 }
    }
  )

  ResearchLabs, ResearchComplexes, AdvancedResearchComplexes = Building.tiered_buildings(
    tier1_name: 'Research Labs',
    tier2_name: 'Research Complexes',
    tier3_name: 'Advanced Research Complexes',
    job: Job::Researcher,
    strategic_resource: :exotic_gases
  )

  AdministrativeOffices, AdministrativePark, AdministrativeComplex = Building.tiered_buildings(
    tier1_name: 'Administrative Offices',
    tier2_name: 'Administrative Park',
    tier3_name: 'Administrative Complex',
    job: Job::Bureaucrat,
    strategic_resource: :rare_crystals
  )

  HoloTheatres, HyperEntertainmentForums = Building.tiered_buildings(
    tier1_name: 'Holo-Theatres',
    tier2_name: 'Hyper-Entertainment Forums',
    job: Job::Entertainer,
    strategic_resource: :exotic_gases
  )

  HydroponicsFarms = Building::Tier1Building.new(
    name: 'Hydroponics Farms',
    job: Job::Farmer
  )

  LuxuryResidences = Building.new(
    name: 'Luxury Residences',
    housing: 3,
    amenities_output: 5,
    upkeep: { energy: 2 }
  )

  ParadiseDome = Building.new(
    name: 'Paradise Dome',
    housing: 6,
    amenities_output: 10,
    upkeep: {
      energy: 5,
      rare_crystals: 1
    }
  )

  CommunalHousing = Building.new(
    name: 'Communal Housing',
    housing: 5,
    amenities_output: 3,
    upkeep: { energy: 2 }
  )

  UtopianCommunalHousing = Building.new(
    name: 'Utopian Communal Housing',
    housing: 10,
    amenities_output: 6,
    upkeep: {
      energy: 5,
      rare_crystals: 1
    }
  )

  SlaveHuts = Building.new(
    name: 'Slave Huts',
    housing: 8,
    upkeep: { energy: 2 }
  )

  PlanetaryShieldGenerator = Building.new(
    name: 'Planetary Shield Generator',
    upkeep: { energy: 5 },
    colony_attribute_modifiers: {
      orbital_bombardment_damage_multiplier: { additive: -0.5 }
    }
  )

  MilitaryAcademy = Building.new(
    name: 'Military Academy',
    max_jobs: { Job::Soldier => 2 },
    upkeep: { energy: 2 },
    colony_attribute_modifiers: {
      army_starting_experience: { additive: 100 }
    }
  )

  DreadEncampment = Building.new(
    name: 'Dread Encampment',
    max_jobs: { Job::Necromancer => 2 },
    upkeep: { energy: 2 },
    colony_attribute_modifiers: {
      army_starting_experience: { additive: 100 }
    }
  )

  ChamberOfElevation = Building.new(
    name: 'Chamber of Elevation',
    max_jobs: { Job::Necrophyte => 1 },
    upkeep: { energy: 2 }
  )

  HouseOfApotheosis = Building.new(
    name: 'House of Apotheosis',
    max_jobs: { Job::Necrophyte => 6 },
    upkeep: {
      energy: 5,
      exotic_gases: 1
    }
  )

  EnergyGrid = Building.new(
    name: 'Energy Grid',
    max_jobs: { Job::Technician => 1 },
    upkeep: { energy: 2 },
    job_output_modifiers: {
      technician?: { energy: { additive: 1 } }
    }
  )

  EnergyNexus = Building.new(
    name: 'Energy Nexus',
    max_jobs: { Job::Technician => 2 },
    upkeep: {
      energy: 2,
      exotic_gases: 1
    },
    job_output_modifiers: {
      technician?: { energy: { additive: 2 } }
    }
  )

  MineralPurificationPlants = Building.new(
    name: 'Mineral Purification Plants',
    max_jobs: { Job::Miner => 1 },
    upkeep: { energy: 2 },
    job_output_modifiers: {
      (->(job) { job.miner? and !job.strategic_resource_miner? }) => { minerals: { additive: 1 } }
    }
  )

  MineralPurificationHubs = Building.new(
    name: 'Mineral Purification Hubs',
    max_jobs: { Job::Miner => 2 },
    upkeep: {
      energy: 2,
      volatile_motes: 1
    },
    job_output_modifiers: {
      Job::ScrapMiner => {
        minerals: { additive: 1 },
        alloys: { additive: 0.5 }
      },
      (->(job) { job.miner? and !job.strategic_resource_miner? }) => { minerals: { additive: 2 } }
    }
  )

  FoodProcessingFacilities = Building.new(
    name: 'Food Processing Facilities',
    max_jobs: { Job::Farmer => 1 },
    upkeep: { energy: 2 },
    job_output_modifiers: {
      farmer?: { food: { additive: 1 } }
    }
  )

  FoodProcessingCenters = Building.new(
    name: 'Food Processing Centers',
    max_jobs: { Job::Farmer => 2 },
    upkeep: {
      energy: 2,
      volatile_motes: 1
    },
    job_output_modifiers: {
      farmer?: { food: { additive: 2 } }
    }
  )
end
