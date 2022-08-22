# frozen_string_literal: true

require_relative './job'
require_relative './resource_group'
require_relative './resource_modifier'

class District
  attr_reader :name, :housing, :max_jobs, :colony_attribute_modifiers

  def initialize(name:, housing: 0, max_jobs: {}, colony_attribute_modifiers: {},
                 upkeep: { energy: 2 })
    @name = name
    @housing = housing
    @max_jobs = max_jobs.dup
    @colony_attribute_modifiers = ResourceModifier.new(colony_attribute_modifiers)
    @upkeep = ResourceGroup.new(upkeep)
  end

  def upkeep
    @upkeep.dup
  end

  def empire_attribute_modifiers
    ResourceModifier::NONE
  end

  CityDistrict = District.new(
    name: 'City District',
    housing: 5,
    max_jobs: { Job::Clerk => 1 },
    colony_attribute_modifiers: { building_slot: { additive: 1 } }
  )

  IndustrialDistrict = District.new(
    name: 'Industrial District',
    housing: 2,
    max_jobs: {
      Job::Artisan => 1,
      Job::Metallurgist => 1
    }
  )

  TradeDistrict = District.new(
    name: 'Trade District',
    housing: 2,
    max_jobs: {
      Job::Artisan => 1,
      Job::Clerk => 1
    }
  )

  GeneratorDistrict = District.new(
    name: 'Generator District',
    housing: 2,
    max_jobs: { Job::Technician => 2 },
    upkeep: { energy: 1 }
  )

  MiningDistrict = District.new(
    name: 'Mining District',
    housing: 2,
    max_jobs: { Job::Miner => 2 },
    upkeep: { energy: 1 }
  )

  AgricultureDistrict = District.new(
    name: 'Agriculture District',
    housing: 2,
    max_jobs: { Job::Farmer => 2 },
    upkeep: { energy: 1 }
  )

  HabitationDistrict = District.new(
    name: 'Habitation District',
    housing: 8
  )

  HabitatIndustrialDistrict = District.new(
    name: 'Industrial District (Habitat)',
    housing: 3,
    max_jobs: {
      Job::Artisan => 1,
      Job::Metallurgist => 1
    }
  )

  HabitatTradeDistrict = District.new(
    name: 'Trade District (Habitat)',
    housing: 3,
    max_jobs: { Job::Clerk => 3 }
  )

  ReactorDistrict = District.new(
    name: 'Reactor District',
    housing: 3,
    max_jobs: { Job::Technician => 3 }
  )

  LeisureDistrict = District.new(
    name: 'Leisure District',
    housing: 3,
    max_jobs: { Job::Entertainer => 3 }
  )

  ResearchDistrict = District.new(
    name: 'Research District',
    housing: 3,
    max_jobs: { Job::Researcher => 3 }
  )

  AstroMiningBay = District.new(
    name: 'Astro-Mining Bay',
    housing: 3,
    max_jobs: { Job::Miner => 3 }
  )

  # Ecumenopolis districts
  ResidentialArcology = District.new(
    name: 'Residential Arcology',
    housing: 15,
    max_jobs: { Job::Clerk => 3 },
    upkeep: { energy: 5 }
  )

  FoundryArcology = District.new(
    name: 'Foundry Arcology',
    housing: 10,
    max_jobs: { Job::Metallurgist => 6 },
    upkeep: {
      energy: 5,
      volatile_motes: 1
    }
  )

  IndustrialArcology = District.new(
    name: 'Industrial Arcology',
    housing: 10,
    max_jobs: { Job::Artisan => 6 },
    upkeep: {
      energy: 5,
      rare_crystals: 1
    }
  )

  LeisureArcology = District.new(
    name: 'Leisure Arcology',
    housing: 10,
    max_jobs: { Job::Entertainer => 6 },
    upkeep: {
      energy: 5,
      exotic_gases: 1
    }
  )

  AdministrativeArcology = District.new(
    name: 'Administrative Arcology',
    housing: 10,
    max_jobs: { Job::Bureaucrat => 6 },
    upkeep: {
      energy: 5,
      rare_crystals: 1
    }
  )

  EcclesiasticalArcology = District.new(
    name: 'Ecclesiastical Arcology',
    housing: 10,
    max_jobs: { Job::Priest => 6 },
    upkeep: {
      energy: 5,
      rare_crystals: 1
    }
  )

  CitySegment = District.new(
    name: 'City Segment',
    housing: 25,
    max_jobs: {
      Job::Clerk => 3,
      Job::Enforcer => 2
    },
    upkeep: { energy: 5 }
  )

  IndustrialSegment = District.new(
    name: 'Industrial Segment',
    housing: 10,
    max_jobs: {
      Job::Artisan => 5,
      Job::Metallurgist => 5
    },
    upkeep: {
      energy: 5,
      volatile_motes: 2
    }
  )

  CommercialSegment = District.new(
    name: 'Commercial Segment',
    housing: 10,
    max_jobs: {
      Job::Clerk => 6,
      Job::Merchant => 2
    },
    upkeep: {
      energy: 5,
      rare_crystals: 2
    }
  )

  GeneratorSegment = District.new(
    name: 'Generator Segment',
    housing: 10,
    max_jobs: { Job::Technician => 10 },
    upkeep: {
      energy: 5,
      rare_crystals: 2
    }
  )

  ResearchSegment = District.new(
    name: 'Research Segment',
    housing: 10,
    max_jobs: { Job::Researcher => 10 },
    upkeep: {
      energy: 5,
      exotic_gases: 2
    }
  )

  AgriculturalSegment = District.new(
    name: 'Agricultural Segment',
    housing: 10,
    max_jobs: { Job::Farmer => 10 },
    upkeep: {
      energy: 5,
      volatile_motes: 2
    }
  )
end
