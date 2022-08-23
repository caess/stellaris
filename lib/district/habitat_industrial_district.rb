# frozen_string_literal: true

require_relative '../job'

class District
  HabitatIndustrialDistrict = District.new(
    name: 'Industrial District (Habitat)',
    housing: 3,
    max_jobs: {
      Job::Artisan => 1,
      Job::Metallurgist => 1
    }
  )
end
