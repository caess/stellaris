# frozen_string_literal: true

require_relative '../job'
require_relative '../modifier'

module Civic
  Rockbreakers = Modifier.new(
    name: 'Rockbreakers',
    job_output_modifiers:
      ->(job) { job.miner? and job.strategic_resource_miner? ? {} : { minerals: { additive: 1 } } }
  )
end
