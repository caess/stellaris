# frozen_string_literal: true

require_relative '../job'

class Building
  HyperEntertainmentForums = Building.tier2_building(
    name: 'Hyper-Entertainment Forums',
    job: Job::Entertainer,
    strategic_resource: :exotic_gases
  )
end
