# frozen_string_literal: true

class Job
  CatalyticTechnician = Job.new(
    name: 'Catalytic Technician',
    strata: :specialist,
    category: :metallurgists,
    output: { alloys: 3 },
    upkeep: { food: 9 }
  )
end
