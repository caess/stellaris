# frozen_string_literal: true

require_relative '../job'
require_relative '../modifier'

module Civic
  PleasureSeekers = Modifier.new(
    name: 'Pleasure Seekers',
    job_colony_attribute_modifiers:
      ->(job) { job.job == Job::Entertainer ? { pop_growth_speed_percent: { additive: 1 } } : {} }
  )
end
