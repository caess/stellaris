class ResourceGroup
  PRODUCED_RESOURCES = [
    :food, :minerals, :energy, :consumer_goods, :alloys, :volatile_motes,
    :exotic_gases, :rare_crystals, :unity, :physics_research,
    :society_research, :engineering_research,
  ]

  def initialize(resources = {})
    @resources = (Hash.new(0)).merge(resources)

    @modifiers = []
    @resolved = nil
  end

  def [](key)
    return nil if !@resources.key?(key)

    resolve if @resolved.nil?

    return @resolved[key]
  end

  def []=(key, value)
    @resources[key] = value
    @resolved = nil
  end

  def <<(modifier)
    @modifiers << modifier
    @resolved = nil
  end

  def resolve()
    return @resolved.dup if !@resolved.nil?

    @resolved = @resources.dup
    total_modifiers = @modifiers.reduce(ResourceModifier::NONE, &:+)

    total_modifiers.values.each do |good, modifiers|
      @resolved[good] += (modifiers[:additive] || 0)
      @resolved[good] *= 1 + (modifiers[:multiplicative] || 0)
    end

    return @resolved.dup
  end

  def +(rhs)
    output = resolve().dup

    rhs.resolve().each do |good, value|
      output[good] += value
    end

    return ResourceGroup.new(output)
  end

  def -(rhs)
    output = resolve().dup

    rhs.resolve().each do |good, value|
      output[good] -= value
    end

    return ResourceGroup.new(output)
  end

  def ==(rhs)
    resolve() == rhs.resolve()
  end

  def dup
    output = ResourceGroup.new(@resources)

    @modifiers.each {|modifier| output << modifier}

    output
  end

  def empty?
    resolve if @resolved.nil?

    @resolved.values.reject {|value| value == 0}.empty?
  end
end
