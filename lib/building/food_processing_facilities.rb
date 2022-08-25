# frozen_string_literal: true

require_relative '../job'

class Building
  FoodProcessingFacilities = Building.new(
    name: 'Food Processing Facilities',
    max_jobs: { Job::Farmer => 1 },
    upkeep: { energy: 2 },
    job_output_modifiers: ->(job) { job.farmer? ? { food: { additive: 1 } } : {} }
  )
end
