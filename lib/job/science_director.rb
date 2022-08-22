# frozen_string_literal: true

class Job
  ScienceDirector = Job.new(
    name: 'Science Director',
    strata: :ruler,
    category: :researchers,
    output: {
      physics_research: 6,
      society_research: 6,
      engineering_research: 6,
      unity: 2
    },
    amenities_output: 3,
    upkeep: { consumer_goods: 2 }
  )
end
