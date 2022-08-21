# frozen_string_literal: true

class Job
  MedicalWorker = Job.new(
    name: 'Medical Worker',
    strata: :specialist,
    category: :doctors,
    amenities_output: 5,
    colony_attribute_modifiers: {
      pop_growth_speed_percent: { additive: 5 },
      organic_pop_assembly_speed_percent: { additive: 5 }
    },
    habitability_modifier: 2.5,
    upkeep: { consumer_goods: 1 }
  )
end
