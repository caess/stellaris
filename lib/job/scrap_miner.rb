# frozen_string_literal: true

class Job
  ScrapMiner = Job.new(
    name: 'Scrap Miner',
    strata: :worker,
    category: :miners,
    output: {
      minerals: 2,
      alloys: 1
    }
  )
end
