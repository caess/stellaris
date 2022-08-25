# frozen_string_literal: true

require_relative '../job'

class Building
  AdministrativeComplex = Building.tier3_building(
    name: 'Administrative Complex',
    job: Job::Bureaucrat,
    strategic_resource: :rare_crystals
  )
end
