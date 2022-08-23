# frozen_string_literal: true

require_relative '../job'

class District
  IndustrialDistrict = District.new(
    name: 'Industrial District',
    housing: 2,
    max_jobs: {
      Job::Artisan => 1,
      Job::Metallurgist => 1
    }
  )
end
