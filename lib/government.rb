# frozen_string_literal: true

require_relative './job'
require_relative './modifier'

module Government
  HiveMind = Modifier.new(
    name: 'Hive Mind',
    job_upkeep_modifiers: lambda do |job|
      if job.job == Job::Necrophyte
        {
          consumer_goods: { additive: -1 },
          food: { multiplicative: 1 },
          minerals: { multiplicative: 1 }
        }
      else
        {}
      end
    end
  )

  MachineIntelligence = Modifier.new(
    name: 'Machine Intelligence',
    job_output_modifiers: lambda do |job|
      if job.job == Job::AgriDrone
        { food: { additive: -1 } }
      elsif job.job == Job::TechDrone
        { energy: { additive: 2 } }
      else
        {}
      end
    end
  )
end
