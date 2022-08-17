require_relative './job'
require_relative './modifier'

module Civic
  # Standard civics
  ByzantineBureaucracy = Modifier.new(
    name: "Byzantine Bureaucracy",
    job_output_modifiers: {
      Job::Bureaucrat => {unity: { additive: 1 } },
      Job::DeathChronicler => {unity: { additive: 1 } },
    },
    job_stability_modifier: {
      Job::Bureaucrat => 1,
    },
  )

  ExaltedPriesthood = Modifier.new(
    name: "Exalted Priesthood",
    job_output_modifiers: {
      :priest? => { unity: { additive: 1 } },
    },
  )

  MiningGuilds = Modifier.new(
    name: "Mining Guilds",
    job_output_modifiers: {
      (->(job) { job.miner? and !job.strategic_resource_miner?}) => {
        minerals: { additive: 1 },
      }
    }
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
