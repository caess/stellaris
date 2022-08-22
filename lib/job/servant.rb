# frozen_string_literal: true

class Job
  Servant = Job.new(
    name: 'Servant',
    strata: :slave,
    amenities_output: 4,
    worker_housing_modifier: { housing: { additive: -0.5 } }
  )
end
