# frozen_string_literal: true

class Job
  CultureWorker = Job.new(
    name: 'Culture Worker',
    strata: :specialist,
    category: :culture_workers,
    output: {
      unity: 3,
      society_research: 3
    },
    upkeep: { consumer_goods: 2 }
  )
end
