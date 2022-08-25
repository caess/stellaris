# frozen_string_literal: true

require_relative '../job'

class Building
  CivilianIndustries = Building.new(
    name: 'Civilian Industries',
    max_jobs: { Job::Artisan => 2 },
    upkeep: { energy: 2 }
  )
end
