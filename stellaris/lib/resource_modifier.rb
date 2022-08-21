# frozen_string_literal: true

require_relative './resource_group'

class ResourceModifier
  attr_reader :values

  def initialize(values = {})
    @values = {}

    source = {}
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
    result = @values.dup

    other.values.each_key do |resource|
      if result.key?(resource)
        other.values[resource].each do |modifier_type, value|
          if modifier_type == :map
            result[resource][modifier_type] = value
          else
            result[resource][modifier_type] ||= 0
            result[resource][modifier_type] += value
          end
        end
      else
        result[resource] = other.values[resource]
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

  NONE = ResourceModifier.new

  def self.multiplyAllProducedResources(value)
    resources = {}
    ResourceGroup::PRODUCED_RESOURCES.each do |resource|
      resources[resource] = { multiplicative: value }
    end

    ResourceModifier.new(resources)
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
end
