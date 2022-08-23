# frozen_string_literal: true

require_relative '../job'

class District
  IndustrialSegment = District.new(
    name: 'Industrial Segment',
    housing: 10,
    max_jobs: {
      Job::Artisan => 5,
      Job::Metallurgist => 5
    },
    upkeep: {
      energy: 5,
      volatile_motes: 2
    }
  )
end
