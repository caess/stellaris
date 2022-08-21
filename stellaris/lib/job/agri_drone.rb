# frozen_string_literal: true

class Job
  AgriDrone = Job.new(
    name: 'Agri-Drone',
    strata: :menial_drone,
    category: :farmers,
    output: { food: 6 }
  )
end
