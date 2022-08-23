# frozen_string_literal: true

require_relative '../job'

class District
  AgricultureDistrict = District.new(
    name: 'Agriculture District',
    housing: 2,
    max_jobs: { Job::Farmer => 2 },
    upkeep: { energy: 1 }
  )
end
