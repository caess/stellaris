# frozen_string_literal: true

module Tradition
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
