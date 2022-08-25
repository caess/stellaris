# frozen_string_literal: true

require_relative '../job'

class Building
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
end
