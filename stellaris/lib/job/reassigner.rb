# frozen_string_literal: true

class Job
  Reassigner = Job.new(
    name: 'Reassigner',
    strata: :specialist,
    colony_attribute_modifiers: {
      monthly_organic_pop_assembly: { additive: 2 }
    },
    upkeep: {
      consumer_goods: 2,
      food: 2
    }
  )
end
