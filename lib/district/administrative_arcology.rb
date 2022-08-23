# frozen_string_literal: true

require_relative '../job'

class District
  AdministrativeArcology = District.new(
    name: 'Administrative Arcology',
    housing: 10,
    max_jobs: { Job::Bureaucrat => 6 },
    upkeep: {
      energy: 5,
      rare_crystals: 1
    }
  )
end
