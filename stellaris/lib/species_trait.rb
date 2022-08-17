require_relative "./modifier"

module SpeciesTrait
  Lithoid = Modifier.new(
    name: "Lithoid",
    job_output_modifiers: {
      Job::Colonist => {
        food: { additive: -1 },
        minerals: { additive: 1 },
      },
      Job::Livestock => {
        food: { additive: -4 },
        minerals: { additive: 2 },
      },
    },
    job_upkeep_modifiers: {
      Job::Necrophyte => {
        food: { additive: -1 },
        minerals: { additive: 1 },
      },
      Job::Reassigner => {
        food: { additive: -2 },
        minerals: { additive: 2 },
      },
    },
  )

  Mechanical = Modifier.new(
    name: "Mechanical",
    founder_species_job_output_modifiers: {
      Job::Technician => { energy: { additive: 2 } },
      Job::Farmer => { food: { additive: -1 } },
    },
  )
end
