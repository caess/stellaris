# frozen_string_literal: true

require_relative './job'
require_relative './modifier'

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

  ForgeSubsidies = Modifier.new(
    name: 'Forge Subsidies',
    job_upkeep_modifiers:
      ->(job) { job.metallurgist? ? { energy: { additive: 1 } } : {} }
  )

  IndustrialSubsidies = Modifier.new(
    name: 'Industrial Subsidies',
    job_upkeep_modifiers:
      ->(job) { job.artisan? ? { energy: { additive: 1 } } : {} }
  )

  MiningSubsidies = Modifier.new(
    name: 'Mining Subsidies',
    job_upkeep_modifiers:
      ->(job) { job.miner? ? { energy: { additive: 0.5 } } : {} }
  )

  ResearchSubsidies = Modifier.new(
    name: 'Research Subsidies',
    job_upkeep_modifiers:
      ->(job) { job.job == Job::Researcher ? { energy: { additive: 1 } } : {} }
  )

  ThoughtEnforcement = Modifier.new(
    name: 'Thought Enforcement',
    job_colony_attribute_modifiers:
      ->(job) { job.job == Job::Telepath ? { crime: { additive: -5 } } : {} }
  )

  # Sacrifice edicts
  HarmonySacrificeEdict = Modifier.new(
    name: 'Harmony Sacrifice Edict',
    job_output_modifiers:
      ->(job) { job.job == Job::DeathPriest ? { unity: { additive: 3 } } : {} }
  )

  TogethernessSacrificeEdict = Modifier.new(
    name: 'Togetherness Sacrifice Edict',
    job_output_modifiers:
      ->(job) { job.job == Job::DeathPriest ? { unity: { additive: 3 } } : {} }
  )

  BountySacrificeEdict = Modifier.new(
    name: 'Bounty Sacrifice Edict',
    job_output_modifiers:
      ->(job) { job.job == Job::DeathPriest ? { unity: { additive: 3 } } : {} }
  )
end
