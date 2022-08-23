# frozen_string_literal: true

require_relative '../job'

class District
  LeisureArcology = District.new(
    name: 'Leisure Arcology',
    housing: 10,
    max_jobs: { Job::Entertainer => 6 },
    upkeep: {
      energy: 5,
      exotic_gases: 1
    }
  )
end
