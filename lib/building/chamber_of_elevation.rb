# frozen_string_literal: true

require_relative '../job'

class Building
  ChamberOfElevation = Building.new(
    name: 'Chamber of Elevation',
    max_jobs: { Job::Necrophyte => 1 },
    upkeep: { energy: 2 }
  )
end
