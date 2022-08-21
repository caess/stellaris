# frozen_string_literal: true

class Job
  ScrapMinerDrone = Job.new(
    name: 'Scrap Miner Drone',
    strata: :menial_drone,
    category: :miners,
    output: {
      minerals: 2,
      alloys: 1
    }
  )
end
