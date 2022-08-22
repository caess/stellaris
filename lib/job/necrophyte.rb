# frozen_string_literal: true

class Job
  Necrophyte = Job.new(
    name: 'Necrophyte',
    strata: :specialist,
    category: :pop_assemblers,
    subcategory: :necro_apprentices,
    output: { unity: 1.5 },
    amenities_output: 5,
    upkeep: {
      consumer_goods: 1,
      food: 1
    }
  )
end
