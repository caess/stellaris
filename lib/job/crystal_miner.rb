# frozen_string_literal: true

class Job
  CrystalMiner = Job.new(
    name: 'Crystal Miner',
    strata: :worker,
    category: :miners,
    subcategory: :strategic_resource_miners,
    output: { rare_crystals: 2 }
  )
end
