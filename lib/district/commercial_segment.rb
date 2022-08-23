# frozen_string_literal: true

require_relative '../job'

class District
  CommercialSegment = District.new(
    name: 'Commercial Segment',
    housing: 10,
    max_jobs: {
      Job::Clerk => 6,
      Job::Merchant => 2
    },
    upkeep: {
      energy: 5,
      rare_crystals: 2
    }
  )
end
