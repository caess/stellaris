# frozen_string_literal: true

require_relative './station'

# rubocop:todo Style/Documentation

class ResearchStation < Station
  def output
    output = super()
    output << @empire.research_station_modifiers if @empire

    output
  end
end

# rubocop:enable Style/Documentation
