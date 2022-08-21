# frozen_string_literal: true

class Job
  OffspringDrone = Job.new(
    name: 'Offspring Drone',
    strata: :complex_drone,
    amenities_output: 5,
    colony_attribute_modifiers: {
      monthly_organic_pop_assembly: { additive: 2 }
    },
    all_job_output_modifiers: lambda do |job|
      if job.menial_drone?
        ResourceModifier.multiplyAllProducedResources(0.1)
      else
        {}
      end
    end,
    upkeep: { food: 5 }
  )
end