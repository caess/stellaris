# frozen_string_literal: true

require_relative '../job'

class District
  GeneratorSegment = District.new(
    name: 'Generator Segment',
    housing: 10,
    max_jobs: { Job::Technician => 10 },
    upkeep: {
      energy: 5,
      rare_crystals: 2
    }
  )
end
