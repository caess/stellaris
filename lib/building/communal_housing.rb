# frozen_string_literal: true

require_relative '../job'

class Building
  CommunalHousing = Building.new(
    name: 'Communal Housing',
    housing: 5,
    amenities_output: 3,
    upkeep: { energy: 2 }
  )
end
