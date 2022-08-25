# frozen_string_literal: true

require_relative '../job'

class Building
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
end
