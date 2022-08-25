# frozen_string_literal: true

require_relative '../job'

class Building
  ResearchComplexes = Building.tier2_building(
    name: 'Research Complexes',
    job: Job::Researcher,
    strategic_resource: :exotic_gases
  )
end
