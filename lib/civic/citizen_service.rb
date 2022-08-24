# frozen_string_literal: true

require_relative '../job'
require_relative '../modifier'

module Civic
  CitizenService = Modifier.new(
    name: 'Citizen Service',
    job_output_modifiers:
      ->(job) { job.job == Job::Soldier ? { unity: { additive: 2 } } : {} }
  )
end
