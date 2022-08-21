# frozen_string_literal: true

require_relative './resource_modifier'

# rubocop:todo Style/Documentation

class Modifier
  attr_reader :name

  def initialize(name: '', **options)
    @name = name

    @options = options
    @options.each_value(&:freeze)
    @options.freeze
  end

  def job_output_modifiers(job)
    resolve_job_modifier(:job_output_modifiers, job)
  end

  def job_upkeep_modifiers(job)
    resolve_job_modifier(:job_upkeep_modifiers, job)
  end

  def job_colony_attribute_modifiers(job)
    resolve_job_modifier(:job_colony_attribute_modifiers, job)
  end

  def job_empire_attribute_modifiers(job)
    resolve_job_modifier(:job_empire_attribute_modifiers, job)
  end

  def job_amenities_output_modifier(job)
    resolve_scalar_job_modifier(:job_amenities_output_modifier, job)
  end

  def job_stability_modifier(job)
    resolve_scalar_job_modifier(:job_stability_modifier, job)
  end

  def job_worker_housing_modifier(job)
    resolve_job_modifier(:job_worker_housing_modifier, job)
  end

  def founder_species_job_output_modifiers(job)
    resolve_job_modifier(:founder_species_job_output_modifiers, job)
  end

  protected

  def resolve_job_modifier(modifier_type, job)
    modifier = @options[modifier_type] || {}

    modifier = modifier.call(job) if modifier.is_a?(Proc) && modifier.lambda?

    ResourceModifier.new(modifier)
  end

  def resolve_scalar_job_modifier(modifier_type, job)
    modifier = @options[modifier_type] || 0

    modifier = modifier.call(job) if modifier.is_a?(Proc) && modifier.lambda?

    modifier
  end
end

# rubocop:enable Style/Documentation
