# frozen_string_literal: true

require_relative '../job'

class Building
  LuxuryResidences = Building.new(
    name: 'Luxury Residences',
    housing: 3,
    amenities_output: 5,
    upkeep: { energy: 2 }
  )
end
