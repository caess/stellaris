require_relative "./resource_group"

class ResourceModifier
  attr_reader :values

  def initialize(values = {})
    @values = {}

    source = {}
    if values.is_a?(ResourceModifier)
      source = values.values.dup
    else
      source = values.dup
    end

    source.each do |key, value|
      @values[key] = value.dup
    end
  end

  def +(rhs)
    result = @values.dup

    rhs.values.each_key do |resource|
      if result.key?(resource)
        rhs.values[resource].each do |modifier_type, value|
          result[resource][modifier_type] ||= 0
          result[resource][modifier_type] += value
        end
      else
        result[resource] = rhs.values[resource]
      end
    end

    return ResourceModifier.new(result)
  end

  def ==(obj)
    @values == obj.values
  end

  NONE = ResourceModifier.new()

  def self.multiplyAllProducedResources(value)
    resources = {}
    ResourceGroup::PRODUCED_RESOURCES.each do |resource|
      resources[resource] = { multiplicative: value }
    end

    return ResourceModifier.new(resources)
  end

  def dup
    ResourceModifier.new(self)
  end
end
