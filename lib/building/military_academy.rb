# frozen_string_literal: true

require_relative '../job'

class Building
  MilitaryAcademy = Building.new(
    name: 'Military Academy',
    max_jobs: { Job::Soldier => 2 },
    upkeep: { energy: 2 },
    colony_attribute_modifiers: {
      army_starting_experience: { additive: 100 }
    }
  )
end
