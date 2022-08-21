# frozen_string_literal: true

class Job
  Technician = Job.new(
    name: 'Technician',
    strata: :worker,
    category: :technicians,
    output: { energy: 6 }
  )
end
