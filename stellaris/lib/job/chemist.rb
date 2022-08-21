# frozen_string_literal: true

class Job
  Chemist = Job.new(
    name: 'Chemist',
    strata: :specialist,
    category: :chemists,
    output: { volatile_motes: 2 },
    upkeep: { minerals: 10 }
  )
end
