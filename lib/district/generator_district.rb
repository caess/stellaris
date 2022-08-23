# frozen_string_literal: true

require_relative '../job'

class District
  GeneratorDistrict = District.new(
    name: 'Generator District',
    housing: 2,
    max_jobs: { Job::Technician => 2 },
    upkeep: { energy: 1 }
  )
end
