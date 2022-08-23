# frozen_string_literal: true

require_relative '../job'

class District
  ResearchSegment = District.new(
    name: 'Research Segment',
    housing: 10,
    max_jobs: { Job::Researcher => 10 },
    upkeep: {
      energy: 5,
      exotic_gases: 2
    }
  )
end
