# frozen_string_literal: true

class Job
  Angler = Job.new(
    name: 'Angler',
    strata: :worker,
    category: :farmers,
    output: {
      food: 8,
      trade: 2
    }
  )
end
