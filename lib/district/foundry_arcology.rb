# frozen_string_literal: true

require_relative '../job'

class District
  FoundryArcology = District.new(
    name: 'Foundry Arcology',
    housing: 10,
    max_jobs: { Job::Metallurgist => 6 },
    upkeep: {
      energy: 5,
      volatile_motes: 1
    }
  )
end
