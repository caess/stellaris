# frozen_string_literal: true

class Job
  MaintenanceDrone = Job.new(
    name: 'Maintenance Drone',
    strata: :menial_drone,
    amenities_output: 4
  )
end
