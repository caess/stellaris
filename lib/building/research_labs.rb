# frozen_string_literal: true

require_relative '../job'

class Building
  ResearchLabs = Building.tier1_building(
    name: 'Research Labs',
    job: Job::Researcher
  )
end
