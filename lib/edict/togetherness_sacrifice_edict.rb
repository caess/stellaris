# frozen_string_literal: true

require_relative '../job'
require_relative '../modifier'

module Edict
  TogethernessSacrificeEdict = Modifier.new(
    name: 'Togetherness Sacrifice Edict',
    job_output_modifiers:
      ->(job) { job.job == Job::DeathPriest ? { unity: { additive: 3 } } : {} }
  )
end
