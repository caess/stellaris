# frozen_string_literal: true

class Job
  Soldier = Job.new(
    name: 'Soldier',
    strata: :worker,
    category: :soldiers,
    colony_attribute_modifiers: {
      defense_armies: { additive: 3 }
    },
    empire_attribute_modifiers: {
      naval_capacity: { additive: 4 }
    }
  )
end
