# frozen_string_literal: true

require_relative '../job'

class District
  ResearchDistrict = District.new(
    name: 'Research District',
    housing: 3,
    max_jobs: { Job::Researcher => 3 }
  )
end
