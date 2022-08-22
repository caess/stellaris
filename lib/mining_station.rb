# frozen_string_literal: true

require_relative './resource_modifier'
require_relative './station'

# rubocop:todo Style/Documentation

class MiningStation < Station
  def output
    output = super()
    output << @empire.mining_station_modifiers if @empire

    output
  end

  def upkeep
    upkeep = super()

    # Energy mining stations have no upkeep
    upkeep << ResourceModifier.new({ energy: { additive: -1 } }) if @output.fetch(:energy, 0).positive?

    upkeep
  end
end

# rubocop:enable Style/Documentation
