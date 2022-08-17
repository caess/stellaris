require_relative "./job"
require_relative "./modifier"

module Edict
  CapacitySubsidies = Modifier.new(
    name: "Capacity Subsidies",
    job_upkeep_modifiers: {
      Job::Technician => { energy: { additive: 0.5 } },
    }
  )

  ForgeSubsidies = Modifier.new(
    name: "Forge Subsidies",
    job_upkeep_modifiers: {
      :metallurgist? => { energy: { additive: 1 } },
    },
  )

  IndustrialSubsidies = Modifier.new(
    name: "Industrial Subsidies",
    job_upkeep_modifiers: {
      :artisan? => { energy: { additive: 1 } },
    }
  )

  ResearchSubsidies = Modifier.new(
    name: "Research Subsidies",
    job_upkeep_modifiers: {
      Job::Researcher => { energy: { additive: 1 } },
    }
  )

  ThoughtEnforcement = Modifier.new(
    name: "Thought Enforcement",
    job_colony_attribute_modifiers: {
      Job::Telepath => { crime: { additive: -5 } },
    }
  )

  # Sacrifice edicts
  HarmonySacrificeEdict = Modifier.new(
    name: "Harmony Sacrifice Edict",
    job_output_modifiers: {
      Job::DeathPriest => { unity: { additive: 3 } },
    }
  )

  TogethernessSacrificeEdict = Modifier.new(
    name: "Togetherness Sacrifice Edict",
    job_output_modifiers: {
      Job::DeathPriest => { unity: { additive: 3 } },
    }
  )

  BountySacrificeEdict = Modifier.new(
    name: "Bounty Sacrifice Edict",
    job_output_modifiers: {
      Job::DeathPriest => { unity: { additive: 3 } },
    }
  )
end