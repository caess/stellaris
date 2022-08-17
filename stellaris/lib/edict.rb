require_relative "./job"
require_relative "./modifier"

module Edict
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

  ThoughtEnforcement = Modifier.new(
    name: "Thought Enforcement",
    job_colony_attribute_modifiers: {
      Job::Telepath => { crime: { additive: -5 } },
    }
  )
end