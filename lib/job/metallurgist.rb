# frozen_string_literal: true

class Job
  Metallurgist = Job.new(
    name: 'Metallurgist',
    strata: :specialist,
    category: :metallurgists,
    output: { alloys: 3 },
    upkeep: { minerals: 6 }
  )
end
