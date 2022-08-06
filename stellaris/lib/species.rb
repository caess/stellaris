require_relative './resource_group'
require_relative './resource_modifier'

class Species
  attr_reader :traits, :living_standard

  def initialize(traits: [], living_standard:)
    @living_standard = living_standard
    @traits = traits.dup
  end

  def job_output_modifiers(job)
    modifier = ResourceModifier.new()

    if @traits.include?(:void_dweller)
      # FIXME - need to check planet type
      modifier += ResourceModifier::multiplyAllProducedResources(0.15)
    end

    if @traits.include?(:intelligent)
      modifier += ResourceModifier.new({
        physics_research: {multiplicative: 0.1},
        society_research: {multiplicative: 0.1},
        engineering_research: {multiplicative: 0.1},
      })
    end

    if @traits.include?(:natural_engineers)
      modifier += ResourceModifier.new({
        engineering_research: {multiplicative: 0.15},
      })
    end

    modifier
  end
end
