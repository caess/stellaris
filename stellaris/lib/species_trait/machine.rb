# frozen_string_literal: true

module SpeciesTrait
  Machine = Modifier.new(
    name: 'Machine',
    job_worker_housing_modifier:
      ->(job) { job.job == Job::Servant ? { housing: { additive: 0.5 } } : {} }
  )
end
