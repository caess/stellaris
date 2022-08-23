# frozen_string_literal: true

require_relative '../job'
require_relative '../modifier'

module Edict
  HarmonySacrificeEdict = Modifier.new(
    name: 'Harmony Sacrifice Edict',
    job_output_modifiers:
      ->(job) { job.job == Job::DeathPriest ? { unity: { additive: 3 } } : {} }
  )
end
