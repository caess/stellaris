# frozen_string_literal: true

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

    @colonies = []
  end

  def add_colony(colony)
    @colonies << colony
  end

  def job_output_modifiers(job)
    modifier = ResourceModifier.new
    modifier += @governor.job_output_modifiers(job)
    modifier += @empire.job_output_modifiers(job)

    modifier
  end

  def job_upkeep_modifiers(job)
    modifier = ResourceModifier.new
    modifier += @empire.job_upkeep_modifiers(job)

    modifier
  end

  def pop_output_modifiers(pop)
    modifier = ResourceModifier.new
    modifier += @empire.pop_output_modifiers(pop)

    modifier
  end

  def job_colony_attribute_modifiers(job)
    modifier = ResourceModifier.new
    modifier += @empire.job_colony_attribute_modifiers(job)

    modifier
  end

  def job_empire_attribute_modifiers(job)
    modifier = ResourceModifier.new
    modifier += @empire.job_empire_attribute_modifiers(job)

    modifier
  end

  def job_amenities_output_modifier(job)
    modifier = 0
    modifier += @empire.job_amenities_output_modifier(job)

    modifier
  end

  def job_stability_modifier(job)
    modifier = 0
    modifier += @empire.job_stability_modifier(job)

    modifier
  end

  def job_worker_housing_modifier(job)
    modifier = ResourceModifier.new
    modifier += @empire.job_worker_housing_modifier(job)

    modifier
  end

  def stability_modifier
    @empire.stability_modifier
  end

  def output
    @colonies.reduce(ResourceGroup.new) do |sum, colony|
      sum + colony.output
    end
  end

  def upkeep
    @colonies.reduce(ResourceGroup.new) do |sum, colony|
      sum + colony.upkeep
    end
  end
end
