require_relative './job'
require_relative './modifier'

module Civic
  # Standard civics
  ExaltedPriesthood = Modifier.new(
    name: "Exalted Priesthood",
    job_output_modifiers: {
      :priest? => { unity: { additive: 1 } },
    },
  )

  PleasureSeekers = Modifier.new(
    name: "Pleasure Seekers",
    job_colony_attribute_modifiers: {
      Job::Entertainer => { pop_growth_speed_percent: { additive: 1 } }
    },
  )

  PoliceState = Modifier.new(
    name: "Police State",
    job_output_modifiers: {
      Job::Enforcer => { unity: { additive: 1 } },
      Job::Telepath => { unity: { additive: 1 } },
    },
  )

  # Corporate civics
  CorporateHedonism = Modifier.new(
    name: "Corporate Hedonism",
    job_colony_attribute_modifiers: {
      Job::Entertainer => { pop_growth_speed_percent: { additive: 1 } }
    },
  )
end
