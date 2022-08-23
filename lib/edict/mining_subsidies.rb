# frozen_string_literal: true

require_relative '../modifier'

module Edict
  MiningSubsidies = Modifier.new(
    name: 'Mining Subsidies',
    job_upkeep_modifiers:
      ->(job) { job.miner? ? { energy: { additive: 0.5 } } : {} }
  )
end
