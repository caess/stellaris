# frozen_string_literal: true

require_relative '../job'

module Government
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
