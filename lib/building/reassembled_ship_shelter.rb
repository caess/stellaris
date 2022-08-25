# frozen_string_literal: true

require_relative '../job'

class Building
  ReassembledShipShelter = Building.new(
    name: 'Reassembled Ship Shelter',
    housing: 3,
    amenities_output: 7,
    max_jobs: { Job::Colonist => 2 },
    upkeep: { energy: 1 },
    colony_attribute_modifiers: { building_slot: { additive: 1 } }
  )
end
