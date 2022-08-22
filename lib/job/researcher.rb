# frozen_string_literal: true

class Job
  Researcher = Job.new(
    name: 'Researcher',
    strata: :specialist,
    category: :researchers,
    output: {
      physics_research: 4,
      society_research: 4,
      engineering_research: 4
    },
    upkeep: { consumer_goods: 2 }
  )
end
