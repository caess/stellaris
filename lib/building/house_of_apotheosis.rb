# frozen_string_literal: true

require_relative '../job'

class Building
  HouseOfApotheosis = Building.new(
    name: 'House of Apotheosis',
    max_jobs: { Job::Necrophyte => 6 },
    upkeep: {
      energy: 5,
      exotic_gases: 1
    }
  )
end
