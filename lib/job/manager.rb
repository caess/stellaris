# frozen_string_literal: true

class Job
  Manager = Job.new(
    name: 'Manager',
    strata: :specialist,
    category: :administrators,
    subcategory: :managers,
    output: {
      unity: 4,
      trade: 2
    },
    upkeep: { consumer_goods: 2 }
  )
end
