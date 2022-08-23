# frozen_string_literal: true

require_relative '../job'

class District
  TradeDistrict = District.new(
    name: 'Trade District',
    housing: 2,
    max_jobs: {
      Job::Artisan => 1,
      Job::Clerk => 1
    }
  )
end
