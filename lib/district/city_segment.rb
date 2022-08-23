# frozen_string_literal: true

require_relative '../job'

class District
  CitySegment = District.new(
    name: 'City Segment',
    housing: 25,
    max_jobs: {
      Job::Clerk => 3,
      Job::Enforcer => 2
    },
    upkeep: { energy: 5 }
  )
end
