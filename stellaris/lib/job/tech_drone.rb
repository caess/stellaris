# frozen_string_literal: true

class Job
  TechDrone = Job.new(
    name: 'Tech-Drone',
    strata: :menial_drone,
    category: :technicians,
    output: { energy: 6 }
  )
end
