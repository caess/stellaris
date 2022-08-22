# frozen_string_literal: true

class Job
  DeathPriest = Job.new(
    name: 'Death Priest',
    strata: :specialist,
    category: :administrators,
    subcategory: :priests,
    output: {
      unity: 3,
      society_research: 1
    },
    amenities_output: 2,
    upkeep: { consumer_goods: 2 }
  )
end
