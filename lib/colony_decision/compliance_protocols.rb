# frozen_string_literal: true

require_relative '../job'

module ColonyDecision
  ComplianceProtocols = Modifier.new(
    name: 'Compliance Protocols',
    job_stability_modifier: ->(job) { job.job == Job::WarriorDrone ? 5 : 0 }
  )
end
