# frozen_string_literal: true

require_relative '../job'

class Building
  MineralPurificationPlants = Building.new(
    name: 'Mineral Purification Plants',
    max_jobs: { Job::Miner => 1 },
    upkeep: { energy: 2 },
    job_output_modifiers: lambda do |job|
      if job.miner? && !job.strategic_resource_miner?
        { minerals: { additive: 1 } }
      else
        {}
      end
    end
  )
end
