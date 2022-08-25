# frozen_string_literal: true

require_relative '../job'

class Building
  ParadiseDome = Building.new(
    name: 'Paradise Dome',
    housing: 6,
    amenities_output: 10,
    upkeep: {
      energy: 5,
      rare_crystals: 1
    }
  )
end
