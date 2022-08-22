# frozen_string_literal: true

require_relative './mixins'
require_relative './resource_group'
require_relative './resource_modifier'

class Station
  attr_accessor :empire

  def initialize(output = {})
    @empire = nil
    @output = ResourceGroup.new(output)
  end

  def output
    @output.dup
  end

  def upkeep
    ResourceGroup.new({ energy: 1 })
  end
end

class MiningStation < Station
  def output
    output = super()
    output << @empire.mining_station_modifiers if @empire

    output
  end

  def upkeep
    upkeep = super()

    # Energy mining stations have no upkeep
    upkeep << ResourceModifier.new({ energy: { additive: -1 } }) if (@output[:energy] || 0).positive?

    upkeep
  end
end

class ResearchStation < Station
  def output
    output = super()
    output << @empire.research_station_modifiers if @empire

    output
  end
end
