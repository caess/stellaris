# frozen_string_literal: true

require_relative '../modifier'

module Edict
  ForgeSubsidies = Modifier.new(
    name: 'Forge Subsidies',
    job_upkeep_modifiers:
      ->(job) { job.metallurgist? ? { energy: { additive: 1 } } : {} }
  )
end
