# frozen_string_literal: true

class Job
  Farmer = Job.new(
    name: 'Farmer',
    strata: :worker,
    category: :farmers,
    output: { food: 6 }
  )
end
