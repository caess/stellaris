# frozen_string_literal: true

# rubocop:todo Style/Documentation

require_relative './resource_group'

class ResourceModifier
  attr_reader :values

  def initialize(values = {})
    @values = {}

    source = if values.is_a?(ResourceModifier)
               values.values.dup
             else
               values.dup
             end

    source.each do |key, value|
      @values[key] = value.dup
    end
  end

  def +(other)
    result = @values.dup.merge(other.values) do |_key, lhs, rhs|
      lhs.merge(rhs) do |type, old_value, new_value|
        type == :map ? new_value : old_value + new_value
      end
    end

    ResourceModifier.new(result)
  end

  def ==(other)
    @values == other.values
  end

  def [](key)
    @values[key] || {}
  end

  def dup
    ResourceModifier.new(self)
  end

  def each(&block)
    @values.each(&block)
  end

  def empty?
    @values.empty?
  end

  NONE = ResourceModifier.new

  class MultiplyAllProducedResources < ResourceModifier
    def initialize(value)
      resources = {}
      ResourceGroup::PRODUCED_RESOURCES.each do |resource|
        resources[resource] = { multiplicative: value }
      end

      super(resources)
    end
  end
end

# rubocop:enable Style/Documentation
