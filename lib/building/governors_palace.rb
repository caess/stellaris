# frozen_string_literal: true

require_relative '../job'

class Building
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
end
