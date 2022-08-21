# frozen_string_literal: true

require_relative './job'
require_relative './modifier'

module Technology
  # Society technologies
  ## Tier 1
  GroundDefensePlanning = Modifier.new(
    name: 'Ground Defense Planning',
    job_empire_attribute_modifiers: lambda do |job|
      if job.job == Job::Necromancer || job.job == Job::Soldier || job.job == Job::WarriorDrone
        { naval_capacity: { additive: 2 } }
      else
        {}
      end
    end
  )
end
