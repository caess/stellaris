# frozen_string_literal: true

class Job
  Executive = Job.new(
    name: 'Executive',
    strata: :ruler,
    category: :politicians,
    subcategory: :executives,
    output: {
      unity: 6,
      trade: 4
    },
    amenities_output: 3,
    upkeep: { consumer_goods: 2 }
  )
end
