# frozen_string_literal: true

require_relative '../job'

module ColonyDecision
  AntiCrimeCampaign = Modifier.new(
    name: 'Anti-Crime Campaign',
    job_upkeep_modifiers: lambda do |job|
      if job.job == Job::Enforcer || job.job == Job::Telepath || job.job == Job::Overseer
        { energy: { additive: 2 } }
      else
        {}
      end
    end,
    job_colony_attribute_modifiers: lambda do |job|
      if job.job == Job::Enforcer || job.job == Job::Telepath
        { crime: { additive: -10 } }
      else
        {}
      end
    end
  )
end
