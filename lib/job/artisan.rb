# frozen_string_literal: true

class Job
  Artisan = Job.new(
    name: 'Artisan',
    strata: :specialist,
    category: :artisans,
    output: { consumer_goods: 6 },
    upkeep: { minerals: 6 }
  )
end
