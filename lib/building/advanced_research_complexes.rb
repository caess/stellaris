# frozen_string_literal: true

require_relative '../job'

class Building
  AdvancedResearchComplexes = Building.tier3_building(
    name: 'Advanced Research Complexes',
    job: Job::Researcher,
    strategic_resource: :exotic_gases
  )
end
