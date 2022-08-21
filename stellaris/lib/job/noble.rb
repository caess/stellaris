# frozen_string_literal: true

class Job
  Noble = Job.new(
    name: 'Noble',
    strata: :ruler,
    category: :politicians,
    subcategory: :nobles,
    output: { unity: 6 },
    amenities_output: 3,
    stability_modifier: 2,
    upkeep: { consumer_goods: 2 }
  )
end
