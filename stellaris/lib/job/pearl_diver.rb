# frozen_string_literal: true

class Job
  PearlDiver = Job.new(
    name: 'Pearl Diver',
    strata: :specialist,
    category: :artisans,
    output: {
      consumer_goods: 3,
      trade: 3
    },
    upkeep: {
      food: 2,
      minerals: 2
    }
  )
end
