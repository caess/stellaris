# frozen_string_literal: true

require_relative '../job'
require_relative '../modifier'

module Edict
  ThoughtEnforcement = Modifier.new(
    name: 'Thought Enforcement',
    job_colony_attribute_modifiers:
      ->(job) { job.job == Job::Telepath ? { crime: { additive: -5 } } : {} }
  )
end
