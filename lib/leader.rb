# frozen_string_literal: true

require_relative './resource_modifier'

# rubocop:todo Style/Documentation

class Leader
  attr_reader :level, :traits
  attr_accessor :role

  def initialize(level:, traits: [])
    @level = level
    @traits = traits.dup
    @role = nil
  end

  def governor?
    @role == :governor
  end

  def ruler?
    @role == :ruler
  end

  # rubocop:todo Metrics/MethodLength
  def job_output_modifiers(job)
    modifier = ResourceModifier.new

    # FIXME: Replace with leader traits.

    if governor?
      modifier += ResourceModifier::MultiplyAllProducedResources.new(
        0.02 * @level
      )

      if @traits.include?(:unifier) && job.administrator?
        modifier += ResourceModifier.new({ unity: { multiplicative: 0.1 } })
      end
    elsif ruler?
      modifier += ResourceModifier.new(minerals: { multiplicative: 0.1 }) if @traits.include?(:industrialist)
    end

    modifier
  end
  # rubocop:enable Metrics/MethodLength

  def colony_attribute_modifiers
    ResourceModifier::NONE
  end

  def empire_attribute_modifiers
    ResourceModifier::NONE
  end

  def empire_base_modifiers
    modifier = ResourceModifier.new

    modifier += ResourceModifier.new(minerals: { multiplicative: 0.1 }) if ruler? && @traits.include?(:industrialist)

    modifier
  end

  def mining_station_modifiers
    modifier = ResourceModifier.new

    modifier += ResourceModifier.new(minerals: { multiplicative: 0.1 }) if ruler? && @traits.include?(:industrialist)

    modifier
  end

  NONE = Leader.new(level: 0)
end

# rubocop:enable Style/Documentation
