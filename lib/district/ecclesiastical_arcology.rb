# frozen_string_literal: true

require_relative '../job'

class District
  EcclesiasticalArcology = District.new(
    name: 'Ecclesiastical Arcology',
    housing: 10,
    max_jobs: { Job::Priest => 6 },
    upkeep: {
      energy: 5,
      rare_crystals: 1
    }
  )
end
