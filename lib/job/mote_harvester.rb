# frozen_string_literal: true

class Job
  MoteHarvester = Job.new(
    name: 'Mote Harvester',
    strata: :worker,
    category: :miners,
    subcategory: :strategic_resource_miners,
    output: { volatile_motes: 2 }
  )
end
