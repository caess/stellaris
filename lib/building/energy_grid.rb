# frozen_string_literal: true

require_relative '../job'

class Building
  EnergyGrid = Building.new(
    name: 'Energy Grid',
    max_jobs: { Job::Technician => 1 },
    upkeep: { energy: 2 },
    job_output_modifiers: ->(job) { job.technician? ? { energy: { additive: 1 } } : {} }
  )
end
