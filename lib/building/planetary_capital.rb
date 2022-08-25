# frozen_string_literal: true

require_relative '../job'

class Building
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
end
