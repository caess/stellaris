# frozen_string_literal: true

module SpeciesTrait
  Mechanical = Modifier.new(
    name: 'Mechanical',
    job_worker_housing_modifier:
      ->(job) { job.job == Job::Servant ? { housing: { additive: 0.5 } } : {} },
    founder_species_job_output_modifiers: lambda do |job|
      if job.job == Job::Technician
        { energy: { additive: 2 } }
      elsif job.job == Job::Farmer
        { food: { additive: -1 } }
      else
        {}
      end
    end
  )
end
