# frozen_string_literal: true

require_relative './job'
require_relative './modifier'

module Tradition
  # Domination
  JudgmentCorps = Modifier.new(
    name: 'Judgment Corps',
    job_output_modifiers: lambda do |job|
      if job.job == Job::Enforcer || job.job == Job::Telepath
        { unity: { additive: 1 } }
      else
        {}
      end
    end
  )

  # Mercantile
  TrickleUpEconomics = Modifier.new(
    name: 'Trickle Up Economics',
    job_output_modifiers: lambda do |job|
      if job.job == Job::Clerk
        { trade: { additive: 1 } }
      else
        {}
      end
    end
  )
end
