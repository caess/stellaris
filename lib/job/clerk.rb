# frozen_string_literal: true

class Job
  Clerk = Job.new(
    name: 'Clerk',
    strata: :worker,
    output: { trade: 4 },
    amenities_output: 2
  )
end
