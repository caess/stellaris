# frozen_string_literal: true

require_relative '../job'

class District
  LeisureDistrict = District.new(
    name: 'Leisure District',
    housing: 3,
    max_jobs: { Job::Entertainer => 3 }
  )
end
