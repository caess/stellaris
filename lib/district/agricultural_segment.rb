# frozen_string_literal: true

require_relative '../job'

class District
  AgriculturalSegment = District.new(
    name: 'Agricultural Segment',
    housing: 10,
    max_jobs: { Job::Farmer => 10 },
    upkeep: {
      energy: 5,
      volatile_motes: 2
    }
  )
end
