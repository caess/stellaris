# frozen_string_literal: true

class Job
  SpawningDrone = Job.new(
    name: 'Spawning Drone',
    strata: :complex_drone,
    amenities_output: 5,
    colony_attribute_modifiers: {
      monthly_organic_pop_assembly: { additive: 2 }
    },
    upkeep: { food: 5 }
  )
end
