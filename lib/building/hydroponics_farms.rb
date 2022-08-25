# frozen_string_literal: true

require_relative '../job'

class Building
  HydroponicsFarms = Building.tier1_building(
    name: 'Hydroponics Farms',
    job: Job::Farmer
  )
end
