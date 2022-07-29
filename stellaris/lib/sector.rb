require_relative './leader'
require_relative './mixins'
require_relative './resource_group'
require_relative './resource_modifier'

class Sector
  include OutputsResources

  attr_reader :empire, :governor

  def initialize(empire:, governor: nil)
    @empire = empire
    @empire.add_sector(self)

    if governor
      @governor = governor
      @governor.role = :governor
    else
      @governor = Leader::NONE
    end

    @planets = []
  end

  def add_planet(planet)
    @planets << planet
  end

  def job_output_modifiers(job)
    modifier = ResourceModifier.new()
    modifier += @governor.job_output_modifiers(job)
    modifier += @empire.job_output_modifiers(job)

    modifier
  end

  def pop_output_modifiers(pop)
    modifier = ResourceModifier.new()
    modifier += @empire.pop_output_modifiers(pop)

    modifier
  end

  def output
    @planets.reduce(ResourceGroup.new()) do |sum, planet|
      sum + planet.output
    end
  end

  def upkeep
    @planets.reduce(ResourceGroup.new()) do |sum, planet|
      sum + planet.upkeep
    end
  end
end
