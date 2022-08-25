# frozen_string_literal: true

require_relative '../job'

class Building
  UtopianCommunalHousing = Building.new(
    name: 'Utopian Communal Housing',
    housing: 10,
    amenities_output: 6,
    upkeep: {
      energy: 5,
      rare_crystals: 1
    }
  )
end
