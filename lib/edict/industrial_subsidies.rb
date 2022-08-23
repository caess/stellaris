# frozen_string_literal: true

require_relative '../modifier'

module Edict
  IndustrialSubsidies = Modifier.new(
    name: 'Industrial Subsidies',
    job_upkeep_modifiers:
      ->(job) { job.artisan? ? { energy: { additive: 1 } } : {} }
  )
end
