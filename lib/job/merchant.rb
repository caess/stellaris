# frozen_string_literal: true

class Job
  Merchant = Job.new(
    name: 'Merchant',
    strata: :ruler,
    category: :merchants,
    output: { trade: 12 },
    amenities_output: 3,
    upkeep: { consumer_goods: 2 }
  )
end
