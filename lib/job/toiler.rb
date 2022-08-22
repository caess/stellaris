# frozen_string_literal: true

class Job
  Toiler = Job.new(
    name: 'Toiler',
    strata: :slave,
    amenities_output: 2
  )
end
