require_relative "./job"
require_relative "./resource_modifier"

class Edict
  attr_reader :name

  def initialize(name: "", job_output_modifiers: {}, job_upkeep_modifiers: {})
    @name = name
    @job_output_modifiers = job_output_modifiers.dup
    @job_upkeep_modifiers = job_upkeep_modifiers.dup
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

  def job_upkeep_modifiers(job)
    return ResourceModifier::NONE if job.nil?

    @job_upkeep_modifiers.each do |key, modifier|
      if key == job.job or
        (key.is_a?(Symbol) and job.respond_to?(key) and job.send(key)) or
        (key.is_a?(Proc) and key.lambda? and key.call(job))
        return ResourceModifier.new(modifier)
      end
    end

    ResourceModifier::NONE
  end

  ForgeSubsidies = Edict.new(
    name: "Forge Subsidies",
    job_upkeep_modifiers: {
      :metallurgist? => { energy: { additive: 1 } },
    },
  )

  IndustrialSubsidies = Edict.new(
    name: "Industrial Subsidies",
    job_upkeep_modifiers: {
      :artisan? => { energy: { additive: 1 } },
    }
  )
end