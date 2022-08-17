require_relative "./job"
require_relative "./modifier"

module Tradition
  # Domination
  JudgmentCorps = Modifier.new(
    name: "Judgment Corps",
    job_output_modifiers: {
      Job::Enforcer => { unity: { additive: 1 } },
      Job::Telepath => { unity: { additive: 1 } },
    },
  )

  # Mercantile
  TrickleUpEconomics = Modifier.new(
    name: "Trickle Up Economics",
    job_output_modifiers: {
      Job::Clerk => { trade: { additive: 1 } },
    },
  )
end
