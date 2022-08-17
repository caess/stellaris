require_relative "./resource_modifier"

class Modifier
  attr_reader :name

  def initialize(name: "", job_output_modifiers: {},
                 job_upkeep_modifiers: {},
                 job_colony_attribute_modifiers: {},
                 job_empire_attribute_modifiers: {},
                 job_amenities_output_modifier: {},
                 job_stability_modifier: {},
                 founder_species_job_output_modifiers: {})
    @name = name
    @job_output_modifiers = job_output_modifiers.dup
    @job_upkeep_modifiers = job_upkeep_modifiers.dup
    @job_colony_attribute_modifiers = job_colony_attribute_modifiers.dup
    @job_empire_attribute_modifiers = job_empire_attribute_modifiers.dup
    @job_amenities_output_modifier = job_amenities_output_modifier.dup
    @job_stability_modifier = job_stability_modifier.dup
    @founder_species_job_output_modifiers = founder_species_job_output_modifiers.dup
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

  def job_colony_attribute_modifiers(job)
    return ResourceModifier::NONE if job.nil?

    @job_colony_attribute_modifiers.each do |key, modifier|
      if key == job.job or
         (key.is_a?(Symbol) and job.respond_to?(key) and job.send(key)) or
         (key.is_a?(Proc) and key.lambda? and key.call(job))
        return ResourceModifier.new(modifier)
      end
    end

    ResourceModifier::NONE
  end

  def job_empire_attribute_modifiers(job)
    return ResourceModifier::NONE if job.nil?

    @job_empire_attribute_modifiers.each do |key, modifier|
      if key == job.job or
         (key.is_a?(Symbol) and job.respond_to?(key) and job.send(key)) or
         (key.is_a?(Proc) and key.lambda? and key.call(job))
        return ResourceModifier.new(modifier)
      end
    end

    ResourceModifier::NONE
  end

  def job_amenities_output_modifier(job)
    return 0 if job.nil?

    @job_amenities_output_modifier.each do |key, modifier|
      if key == job.job or
         (key.is_a?(Symbol) and job.respond_to?(key) and job.send(key)) or
         (key.is_a?(Proc) and key.lambda? and key.call(job))
        return modifier
      end
    end

    0
  end

  def job_stability_modifier(job)
    return 0 if job.nil?

    @job_stability_modifier.each do |key, modifier|
      if key == job.job or
         (key.is_a?(Symbol) and job.respond_to?(key) and job.send(key)) or
         (key.is_a?(Proc) and key.lambda? and key.call(job))
        return modifier
      end
    end

    0
  end

  def founder_species_job_output_modifiers(job)
    return ResourceModifier::NONE if job.nil?

    @founder_species_job_output_modifiers.each do |key, modifier|
      if key == job.job or
         (key.is_a?(Symbol) and job.respond_to?(key) and job.send(key)) or
         (key.is_a?(Proc) and key.lambda? and key.call(job))
        return ResourceModifier.new(modifier)
      end
    end

    ResourceModifier::NONE
  end
end
