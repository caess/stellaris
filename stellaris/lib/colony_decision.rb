require_relative "./job"
require_relative "./modifier"

module ColonyDecision
  AntiCrimeCampaign = Modifier.new(
    name: "Anti-Crime Campaign",
    job_upkeep_modifiers: {
      Job::Enforcer => { energy: { additive: 2 } },
      Job::Telepath => { energy: { additive: 2 } },
      Job::Overseer => { energy: { additive: 2 } },
    },
    job_colony_attribute_modifiers: {
      Job::Enforcer => { crime: { additive: -10 } },
      Job::Telepath => { crime: { additive: -10 } },
    },
  )

  MartialLaw = Modifier.new(
    name: "Martial Law",
    job_colony_attribute_modifiers: {
      Job::Necromancer => { defense_armies: { additive: 2 } },
    },
    job_stability_modifier: {
      Job::Soldier => 5,
    },
  )
end
