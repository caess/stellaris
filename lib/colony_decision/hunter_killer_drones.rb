# frozen_string_literal: true

require_relative '../job'

module ColonyDecision
  HunterKillerDrones = Modifier.new(
    name: 'Hunter-Killer Drones',
    job_stability_modifier: ->(job) { job.job == Job::WarriorDrone ? 5 : 0 }
  )
end
