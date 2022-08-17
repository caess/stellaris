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
      }
    },
  )
end