# frozen_string_literal: true

require_relative '../job'
require_relative '../modifier'

module Civic
  MaintenanceProtocols = Modifier.new(
    name: 'Maintenance Protocols',
    job_output_modifiers:
      ->(job) { job.job == Job::MaintenanceDrone ? { unity: { additive: 1 } } : {} }
  )
end
