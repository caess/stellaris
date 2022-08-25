# frozen_string_literal: true

require_relative '../job'

class Building
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
end
