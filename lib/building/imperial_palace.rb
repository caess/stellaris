# frozen_string_literal: true

require_relative '../job'

class Building
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
end
