# frozen_string_literal: true

require_relative '../job'

class Building
  SlaveHuts = Building.new(
    name: 'Slave Huts',
    housing: 8,
    upkeep: { energy: 2 }
  )
end
