require_relative "./modifier"

class SpeciesTrait
  Lithoid = Modifier.new(
    name: "Lithoid",
    job_output_modifiers: {
      Job::Colonist => {
        food: { additive: -1 },
        minerals: { additive: 1 },
      }
    }
  )
end