# frozen_string_literal: true

class Job
  GasRefiner = Job.new(
    name: 'Gas Refiner',
    strata: :specialist,
    category: :refiners,
    output: { exotic_gases: 2 },
    upkeep: { minerals: 10 }
  )
end
