# frozen_string_literal: true

class Job
  MiningDrone = Job.new(
    name: 'Mining Drone',
    strata: :menial_drone,
    category: :miners,
    output: { minerals: 4 }
  )
end
