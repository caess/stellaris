# frozen_string_literal: true

require_relative '../job'
require_relative '../modifier'

module Edict
  ResearchSubsidies = Modifier.new(
    name: 'Research Subsidies',
    job_upkeep_modifiers:
      ->(job) { job.job == Job::Researcher ? { energy: { additive: 1 } } : {} }
  )
end
