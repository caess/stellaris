# frozen_string_literal: true

class Job
  Bureaucrat = Job.new(
    name: 'Bureaucrat',
    strata: :specialist,
    category: :administrators,
    output: { unity: 4 },
    upkeep: { consumer_goods: 2 }
  )
end
