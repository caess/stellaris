# frozen_string_literal: true

require_relative '../job'

class Building
  DreadEncampment = Building.new(
    name: 'Dread Encampment',
    max_jobs: { Job::Necromancer => 2 },
    upkeep: { energy: 2 },
    colony_attribute_modifiers: {
      army_starting_experience: { additive: 100 }
    }
  )
end
