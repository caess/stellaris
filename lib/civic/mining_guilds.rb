# frozen_string_literal: true

require_relative '../modifier'

module Civic
  MiningGuilds = Modifier.new(
    name: 'Mining Guilds',
    job_output_modifiers:
      ->(job) { job.miner? and job.strategic_resource_miner? ? {} : { minerals: { additive: 1 } } }
  )
end
