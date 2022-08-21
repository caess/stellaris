# frozen_string_literal: true

class Job
  Replicator = Job.new(
    name: 'Replicator',
    strata: :complex_drone,
    category: :pop_assemblers,
    colony_attribute_modifiers: {
      monthly_mechanical_pop_assembly: { additive: 1 }
    },
    upkeep: { alloys: 1 }
  )
end
