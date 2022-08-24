# frozen_string_literal: true

require_relative '../modifier'

module Civic
  ExaltedPriesthood = Modifier.new(
    name: 'Exalted Priesthood',
    job_output_modifiers:
      ->(job) { job.priest? ? { unity: { additive: 1 } } : {} }
  )
end
