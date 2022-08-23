# frozen_string_literal: true

require_relative '../job'

class District
  ReactorDistrict = District.new(
    name: 'Reactor District',
    housing: 3,
    max_jobs: { Job::Technician => 3 }
  )
end
