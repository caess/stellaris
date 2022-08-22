# frozen_string_literal: true

class Job
  MortalInitiate = Job.new(
    name: 'Mortal Initiate',
    strata: :worker,
    category: :administrators,
    output: {
      unity: 2,
      society_research: 1
    },
    amenities_output: 2
  )
end
