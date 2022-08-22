# frozen_string_literal: true

class Job
  Politician = Job.new(
    name: 'Politician',
    strata: :ruler,
    category: :politicians,
    output: { unity: 6 },
    amenities_output: 3,
    upkeep: { consumer_goods: 2 }
  )
end
