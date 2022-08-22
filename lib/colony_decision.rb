# frozen_string_literal: true

require_relative './job'
require_relative './modifier'

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

  ComplianceProtocols = Modifier.new(
    name: 'Compliance Protocols',
    job_stability_modifier: ->(job) { job.job == Job::WarriorDrone ? 5 : 0 }
  )

  HunterKillerDrones = Modifier.new(
    name: 'Hunter-Killer Drones',
    job_stability_modifier: ->(job) { job.job == Job::WarriorDrone ? 5 : 0 }
  )

  MartialLaw = Modifier.new(
    name: 'Martial Law',
    job_colony_attribute_modifiers:
      ->(job) { job.job == Job::Necromancer ? { defense_armies: { additive: 2 } } : {} },
    job_stability_modifier: ->(job) { job.job == Job::Soldier ? 5 : 0 }
  )
end
