# frozen_string_literal: true

class Job
  Artificer = Job.new(
    name: 'Artificer',
    strata: :specialist,
    category: :artisans,
    output: {
      consumer_goods: 7,
      trade: 2,
      engineering_research: 1.1
    },
    upkeep: { minerals: 6 }
  )
end
