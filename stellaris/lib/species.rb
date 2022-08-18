# frozen_string_literal: true

require_relative './resource_group'
require_relative './resource_modifier'
require_relative './species_trait'

class Species
  attr_reader :traits, :living_standard

  def initialize(living_standard:, traits: [])
    @living_standard = living_standard
    @traits = traits.dup
  end

  def job_output_modifiers(job)
    modifier = ResourceModifier.new

    if @traits.include?(:void_dweller)
      # FIXME: - need to check planet type
      modifier += ResourceModifier.multiplyAllProducedResources(0.15)
    end

    if @traits.include?(:intelligent)
      modifier += ResourceModifier.new({
                                         physics_research: { multiplicative: 0.1 },
                                         society_research: { multiplicative: 0.1 },
                                         engineering_research: { multiplicative: 0.1 }
                                       })
    end

    if @traits.include?(:natural_engineers)
      modifier += ResourceModifier.new({
                                         engineering_research: { multiplicative: 0.15 }
                                       })
    end

    @traits.filter { |x| x.is_a?(Modifier) }.each do |trait|
      modifier += trait.job_output_modifiers(job)
    end

    modifier
  end

  def job_upkeep_modifiers(job)
    modifier = ResourceModifier.new

    @traits.filter { |x| x.is_a?(Modifier) }.each do |trait|
      modifier += trait.job_upkeep_modifiers(job)
    end

    modifier
  end

  def job_worker_housing_modifier(job)
    modifier = ResourceModifier.new

    @traits.filter { |x| x.is_a?(Modifier) }.each do |trait|
      modifier += trait.job_worker_housing_modifier(job)
    end

    modifier
  end

  def founder_species_job_output_modifiers(job)
    modifier = ResourceModifier.new

    @traits.filter { |x| x.is_a?(Modifier) }.each do |trait|
      modifier += trait.founder_species_job_output_modifiers(job)
    end

    modifier
  end
end
