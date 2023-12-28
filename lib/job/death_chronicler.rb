# frozen_string_literal: true

class Job
  DeathChronicler = Job.new(
    name: 'Death Chronicler',
    strata: :specialist,
    category: :administrators,
    output: {
      unity: 2,
      society_research: 2
    },
    amenities_output: 2,
    stability_modifier: 2,
    upkeep: {
      consumer_goods: 2,
      food: 1
    }
  )
end
