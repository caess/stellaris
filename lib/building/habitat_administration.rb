# frozen_string_literal: true

require_relative '../job'

class Building
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
end
