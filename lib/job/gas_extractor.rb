# frozen_string_literal: true

class Job
  GasExtractor = Job.new(
    name: 'Gas Extractor',
    strata: :worker,
    category: :miners,
    subcategory: :strategic_resource_miners,
    output: { exotic_gases: 2 }
  )
end
