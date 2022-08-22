# frozen_string_literal: true

class Job
  Duelist = Job.new(
    name: 'Duelist',
    strata: :specialist,
    category: :entertainers,
    output: { unity: 2 },
    amenities_output: 10,
    empire_attribute_modifiers: { naval_capacity: { additive: 2 } },
    upkeep: { alloys: 1 }
  )
end
