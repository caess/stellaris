# frozen_string_literal: true

class Job
  Necromancer = Job.new(
    name: 'Necromancer',
    strata: :specialist,
    category: :researchers,
    output: {
      physics_research: 6,
      society_research: 6
    },
    colony_attribute_modifiers: { defense_armies: { additive: 3 } },
    empire_attribute_modifiers: { naval_capacity: { additive: 2 } },
    upkeep: { consumer_goods: 2 }
  )
end
