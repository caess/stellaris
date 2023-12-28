# frozen_string_literal: true

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
      when Job::Necrophyte, Job::DeathChronicler
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
end
