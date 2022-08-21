# frozen_string_literal: true

class Job
  Telepath = Job.new(
    name: 'Telepath',
    strata: :specialist,
    category: :administrators,
    subcategory: :telepaths,
    output: { unity: 6 },
    colony_attribute_modifiers: { crime: { additive: -35 } },
    all_job_output_modifiers: ResourceModifier.multiplyAllProducedResources(0.05),
    upkeep: { energy: 1 }
  )
end
