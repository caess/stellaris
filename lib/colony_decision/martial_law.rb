# frozen_string_literal: true

require_relative '../job'

module ColonyDecision
  MartialLaw = Modifier.new(
    name: 'Martial Law',
    job_colony_attribute_modifiers:
      ->(job) { job.job == Job::Necromancer ? { defense_armies: { additive: 2 } } : {} },
    job_stability_modifier: ->(job) { job.job == Job::Soldier ? 5 : 0 }
  )
end
