# frozen_string_literal: true

require_relative '../job'

class Building
  AdministrativePark = Building.tier2_building(
    name: 'Administrative Park',
    job: Job::Bureaucrat,
    strategic_resource: :rare_crystals
  )
end
