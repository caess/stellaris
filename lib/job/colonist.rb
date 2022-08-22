# frozen_string_literal: true

class Job
  Colonist = Job.new(
    name: 'Colonist',
    strata: :specialist,
    output: { food: 1 },
    amenities_output: 3,
    colony_attribute_modifiers: {
      defense_armies: { additive: 1 }
    }
  )
end
