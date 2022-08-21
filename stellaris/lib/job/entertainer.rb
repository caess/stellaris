# frozen_string_literal: true

class Job
  Entertainer = Job.new(
    name: 'Entertainer',
    strata: :specialist,
    category: :entertainers,
    output: { unity: 1 },
    amenities_output: 10,
    upkeep: { consumer_goods: 1 }
  )
end
