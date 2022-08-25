# frozen_string_literal: true

require_relative '../job'

class Building
  FoodProcessingCenters = Building.new(
    name: 'Food Processing Centers',
    max_jobs: { Job::Farmer => 2 },
    upkeep: {
      energy: 2,
      volatile_motes: 1
    },
    job_output_modifiers: ->(job) { job.farmer? ? { food: { additive: 2 } } : {} }
  )
end
