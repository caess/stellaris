# frozen_string_literal: true

class Job
  Livestock = Job.new(
    name: 'Livestock',
    strata: :slave,
    output: { food: 4 },
    worker_housing_modifier: { housing: { additive: -0.5 } },
    worker_political_power_modifier: { political_power: { additive: -0.1 } }
  )
end
