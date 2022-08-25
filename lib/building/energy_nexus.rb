# frozen_string_literal: true

require_relative '../job'

class Building
  EnergyNexus = Building.new(
    name: 'Energy Nexus',
    max_jobs: { Job::Technician => 2 },
    upkeep: {
      energy: 2,
      exotic_gases: 1
    },
    job_output_modifiers: ->(job) { job.technician? ? { energy: { additive: 2 } } : {} }
  )
end
