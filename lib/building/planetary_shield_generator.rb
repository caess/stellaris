# frozen_string_literal: true

require_relative '../job'

class Building
  PlanetaryShieldGenerator = Building.new(
    name: 'Planetary Shield Generator',
    upkeep: { energy: 5 },
    colony_attribute_modifiers: {
      orbital_bombardment_damage_multiplier: { additive: -0.5 }
    }
  )
end
