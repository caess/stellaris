# frozen_string_literal: true

class Job
  Miner = Job.new(
    name: 'Miner',
    strata: :worker,
    category: :miners,
    output: { minerals: 4 }
  )
end
