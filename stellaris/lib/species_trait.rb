# frozen_string_literal: true

require_relative './modifier'

module SpeciesTrait
  Lithoid = Modifier.new(
    name: 'Lithoid',
    job_output_modifiers: lambda do |job|
      if job.job == Job::Colonist
        {
          food: { additive: -1 },
          minerals: { additive: 1 }
        }
      elsif job.job == Job::Livestock
        {
          food: { additive: -4 },
          minerals: { additive: 2 }
        }
      else
        {}
      end
    end,
    job_upkeep_modifiers: lambda do |job|
      case job.job
      when Job::Necrophyte
        {
          food: { additive: -1 },
          minerals: { additive: 1 }
        }
      when Job::Reassigner
        {
          food: { additive: -2 },
          minerals: { additive: 2 }
        }
      when Job::SpawningDrone, Job::OffspringDrone
        {
          food: { additive: -5 },
          minerals: { additive: 5 }
        }
      else
        {}
      end
    end
  )

  Machine = Modifier.new(
    name: 'Machine',
    job_worker_housing_modifier:
      ->(job) { job.job == Job::Servant ? { housing: { additive: 0.5 } } : {} }
  )

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
