# frozen_string_literal: true

class Job
  Roboticist = Job.new(
    name: 'Roboticist',
    strata: :specialist,
    category: :pop_assemblers,
    colony_attribute_modifiers: {
      monthly_mechanical_pop_assembly: { additive: 2 }
    },
    upkeep: { alloys: 2 }
  )
end
