# frozen_string_literal: true

require_relative '../job'

class District
  IndustrialArcology = District.new(
    name: 'Industrial Arcology',
    housing: 10,
    max_jobs: { Job::Artisan => 6 },
    upkeep: {
      energy: 5,
      rare_crystals: 1
    }
  )
end
