require_relative './resource_modifier'

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

  def job_output_modifiers(job)
    modifier = ResourceModifier.new()

    if governor?
      modifier += ResourceModifier::multiplyAllProducedResources(
        0.02 * @level
      )

      if @traits.include?(:unifier)
        if job.job == :bureaucrat
          modifier += ResourceModifier.new({unity: {multiplicative: 0.1}})
        end
      end
    elsif ruler?
      if @traits.include?(:industrialist)
        modifier += ResourceModifier.new(minerals: {multiplicative: 0.1})
      end
    end

    modifier
  end

  NONE = Leader.new(level: 0)
end
