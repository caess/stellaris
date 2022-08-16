require_relative "./resource_modifier"

class SpeciesTrait
  attr_reader :name

  def initialize(name: "", job_output_modifiers: {})
    @name = name
    @job_output_modifiers = job_output_modifiers.dup
  end

  def job_output_modifiers(job)
    return ResourceModifier::NONE if job.nil?

    @job_output_modifiers.each do |key, modifier|
      if key == job.job or
        (key.is_a?(Symbol) and job.respond_to?(key) and job.send(key)) or
        (key.is_a?(Proc) and key.lambda? and key.call(job))
        return ResourceModifier.new(modifier)
      end
    end

    ResourceModifier::NONE
  end

  Lithoid = SpeciesTrait.new(
    name: "Lithoid",
    job_output_modifiers: {
      Job::Colonist => {
        food: { additive: -1 },
        minerals: { additive: 1 },
      }
    }
  )
end