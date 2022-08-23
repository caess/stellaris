# frozen_string_literal: true

require_relative '../job'
require_relative '../modifier'

module Edict
  CapacitySubsidies = Modifier.new(
    name: 'Capacity Subsidies',
    job_upkeep_modifiers: lambda do |job|
      if job.job == Job::Technician || job.job == Job::TechDrone
        { energy: { additive: 0.5 } }
      else
        {}
      end
    end
  )
end
