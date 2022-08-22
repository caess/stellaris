# frozen_string_literal: true

class Job
  HighPriest = Job.new(
    name: 'High Priest',
    strata: :ruler,
    category: :administrators,
    subcategory: :priests,
    output: { unity: 6 },
    amenities_output: 5,
    upkeep: { consumer_goods: 2 }
  )
end
