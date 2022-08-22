# frozen_string_literal: true

class Job
  Overseer = Job.new(
    name: 'Overseer',
    strata: :slave,
    category: :enforcers,
    colony_attribute_modifiers: {
      crime: { additive: -25 },
      defense_armies: { additive: 2 }
    },
    pop_happiness_modifiers: 25
  )
end
