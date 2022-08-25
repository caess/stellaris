# frozen_string_literal: true

require_relative '../job'

class Building
  MineralPurificationHubs = Building.new(
    name: 'Mineral Purification Hubs',
    max_jobs: { Job::Miner => 2 },
    upkeep: {
      energy: 2,
      volatile_motes: 1
    },
    job_output_modifiers: lambda do |job|
      if job.job == Job::ScrapMiner
        { minerals: { additive: 1 }, alloys: { additive: 0.5 } }
      elsif job.miner? && !job.strategic_resource_miner?
        { minerals: { additive: 2 } }
      else
        {}
      end
    end
  )
end
