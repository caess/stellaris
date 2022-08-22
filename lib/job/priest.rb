# frozen_string_literal: true

class Job
  Priest = Job.new(
    name: 'Priest',
    strata: :specialist,
    category: :administrators,
    subcategory: :priests,
    output: { unity: 4 },
    amenities_output: 2,
    upkeep: { consumer_goods: 2 }
  )
end
