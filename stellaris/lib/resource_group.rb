# frozen_string_literal: true

class ResourceGroup
  PRODUCED_RESOURCES = %i[
    food minerals energy consumer_goods alloys volatile_motes
    exotic_gases rare_crystals unity physics_research
    society_research engineering_research
  ].freeze

  def initialize(resources = {})
    @resources = Hash.new(0).merge(resources)

    @modifiers = []
    @resolved = nil
  end

  def [](key)
    return nil unless @resources.key?(key)

    resolve if @resolved.nil?

    @resolved[key]
  end

  def []=(key, value)
    @resources[key] = value
    @resolved = nil
  end

  def <<(modifier)
    @modifiers << modifier
    @resolved = nil
  end

  def resolve
    return @resolved.dup unless @resolved.nil?

    @resolved = @resources.dup
    total_modifiers = @modifiers.reduce(ResourceModifier::NONE, &:+)

    total_modifiers.each do |good, modifiers|
      @resolved[good] += (modifiers[:additive] || 0)
      @resolved[good] *= 1 + (modifiers[:multiplicative] || 0)
    end

    @resolved.dup
  end

  def +(other)
    output = resolve.dup

    other.resolve.each do |good, value|
      output[good] += value
    end

    ResourceGroup.new(output)
  end

  def -(other)
    output = resolve.dup

    other.resolve.each do |good, value|
      output[good] -= value
    end

    ResourceGroup.new(output)
  end

  def ==(other)
    resolve.reject { |_k, v| v.zero? } == other.resolve.reject { |_k, v| v.zero? }
  end

  def dup
    output = ResourceGroup.new(@resources)

    @modifiers.each { |modifier| output << modifier }

    output
  end

  def empty?
    resolve if @resolved.nil?

    @resolved.values.reject(&:zero?).empty?
  end

  EMPTY = ResourceGroup.new({})
end
