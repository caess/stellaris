require_relative './modifier'

module Civic
  ExaltedPriesthood = Modifier.new(
    name: "Exalted Priesthood",
    job_output_modifiers: {
      :priest? => { unity: { additive: 1 } },
    },
  )
end
