# frozen_string_literal: true

require_relative '../job'

class District
  CityDistrict = District.new(
    name: 'City District',
    housing: 5,
    max_jobs: { Job::Clerk => 1 },
    colony_attribute_modifiers: { building_slot: { additive: 1 } }
  )
end
