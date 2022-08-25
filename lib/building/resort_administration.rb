# frozen_string_literal: true

require_relative '../job'

class Building
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
end
