# frozen_string_literal: true

require_relative '../job'

class District
  MiningDistrict = District.new(
    name: 'Mining District',
    housing: 2,
    max_jobs: { Job::Miner => 2 },
    upkeep: { energy: 1 }
  )
end
