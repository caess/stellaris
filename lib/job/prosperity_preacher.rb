# frozen_string_literal: true

class Job
  ProsperityPreacher = Job.new(
    name: 'Prosperity Preacher',
    strata: :worker,
    category: :administrators,
    subcategory: :priests,
    output: {
      unity: 1,
      trade: 4
    },
    amenities_output: 3
  )
end
