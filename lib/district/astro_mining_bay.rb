# frozen_string_literal: true

require_relative '../job'

class District
  AstroMiningBay = District.new(
    name: 'Astro-Mining Bay',
    housing: 3,
    max_jobs: { Job::Miner => 3 }
  )
end
