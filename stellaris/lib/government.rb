require_relative "./job"
require_relative "./modifier"

module Government
  HiveMind = Modifier.new(
    name: "Hive Mind",
    job_upkeep_modifiers: {
      Job::Necrophyte => {
        consumer_goods: { additive: -1 },
        food: { multiplicative: 1 },
        minerals: { multiplicative: 1 },
      },
    },
  )

  MachineIntelligence = Modifier.new(
    name: "Machine Intelligence",
    job_output_modifiers: {
      Job::AgriDrone => { food: { additive: -1 } },
      Job::TechDrone => { energy: { additive: 2 } },
    },
  )
end
