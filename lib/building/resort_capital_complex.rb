# frozen_string_literal: true

require_relative '../job'

class Building
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
end
