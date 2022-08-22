# frozen_string_literal: true

module Tradition
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
end
