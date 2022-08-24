# frozen_string_literal: true

require_relative '../job'
require_relative '../modifier'

module Civic
  ByzantineBureaucracy = Modifier.new(
    name: 'Byzantine Bureaucracy',
    job_output_modifiers: lambda do |job|
      if job.job == Job::Bureaucrat || job.job == Job::DeathChronicler
        { unity: { additive: 1 } }
      else
        {}
      end
    end,
    job_stability_modifier:
      ->(job) { job.job == Job::Bureaucrat ? 1 : 0 }
  )
end
