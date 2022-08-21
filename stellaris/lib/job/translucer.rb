# frozen_string_literal: true

class Job
  Translucer = Job.new(
    name: 'Translucer',
    strata: :specialist,
    category: :translucers,
    output: { rare_crystals: 2 },
    upkeep: { minerals: 10 }
  )
end
