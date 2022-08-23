# frozen_string_literal: true

require_relative '../job'

class District
  ResidentialArcology = District.new(
    name: 'Residential Arcology',
    housing: 15,
    max_jobs: { Job::Clerk => 3 },
    upkeep: { energy: 5 }
  )
end
