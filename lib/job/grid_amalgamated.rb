# frozen_string_literal: true

class Job
  GridAmalgamated = Job.new(
    name: 'Grid Amalgamated',
    strata: :slave,
    output: { energy: 4 },
    worker_housing_modifier: { housing: { additive: -0.5 } }
  )
end
