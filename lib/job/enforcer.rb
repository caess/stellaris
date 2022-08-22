# frozen_string_literal: true

class Job
  Enforcer = Job.new(
    name: 'Enforcer',
    strata: :specialist,
    category: :enforcers,
    stability_modifier: 1,
    colony_attribute_modifiers: {
      crime: { additive: -25 },
      defense_armies: { additive: 2 }
    }
  )
end
