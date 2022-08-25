# frozen_string_literal: true

require_relative '../job'

class Building
  AdministrativeOffices = Building.tier1_building(
    name: 'Administrative Offices',
    job: Job::Bureaucrat
  )
end
