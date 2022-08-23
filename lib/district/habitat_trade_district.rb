# frozen_string_literal: true

require_relative '../job'

class District
  HabitatTradeDistrict = District.new(
    name: 'Trade District (Habitat)',
    housing: 3,
    max_jobs: { Job::Clerk => 3 }
  )
end
