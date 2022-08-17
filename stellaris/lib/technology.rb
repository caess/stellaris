require_relative "./job"
require_relative "./modifier"

module Technology
  # Society technologies
  ## Tier 1
  GroundDefensePlanning = Modifier.new(
    name: "Ground Defense Planning",
    job_empire_attribute_modifiers: {
      Job::Necromancer => { naval_capacity: { additive: 2 } },
      Job::Soldier => { naval_capacity: { additive: 2 } },
    },
  )
end
