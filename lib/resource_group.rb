# frozen_string_literal: true

# rubocop:todo Style/Documentation

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
    resolve if @resolved.nil?

    @resolved[key]
  end

  def fetch(key, default)
    resolve if @resolved.nil?
    @resolved.fetch(key, default)
  end

  def []=(key, value)
    @resources[key] = value
    @resolved = nil
  end

  def <<(modifier)
    @modifiers << modifier
    @resolved = nil
  end

  # rubocop:todo Metrics/AbcSize, Metrics/MethodLength
  def resolve
    return @resolved.dup unless @resolved.nil?

    maps = {}

    @resolved = @resources.dup
    total_modifiers = @modifiers.reduce(ResourceModifier::NONE, &:+)

    total_modifiers.each do |good, modifiers|
      @resolved[good] += modifiers.fetch(:additive, 0)
      @resolved[good] *= 1 + modifiers.fetch(:multiplicative, 0)
      maps[good] = modifiers[:map] if modifiers.key?(:map)
    end

    maps.each do |good, replacement|
      @resolved[replacement] ||= 0
      @resolved[replacement] += @resolved[good]
      @resolved[good] = 0
    end

    @resolved.dup
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

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

# rubocop:enable Style/Documentation
