# frozen_string_literal: true

require_relative '../job'

class Building
  HoloTheatres = Building.tier1_building(
    name: 'Holo-Theatres',
    job: Job::Entertainer
  )
end
