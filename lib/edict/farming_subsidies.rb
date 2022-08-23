# frozen_string_literal: true

require_relative '../job'
require_relative '../modifier'

module Edict
  FarmingSubsidies = Modifier.new(
    name: 'Farming Subsidies',
    job_upkeep_modifiers: lambda do |job|
      if job.job == Job::Farmer || job.job == Job::AgriDrone
        { energy: { additive: 0.5 } }
      else
        {}
      end
    end
  )
end
