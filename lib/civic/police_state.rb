# frozen_string_literal: true

require_relative '../job'
require_relative '../modifier'

module Civic
  PoliceState = Modifier.new(
    name: 'Police State',
    job_output_modifiers: lambda do |job|
      if job.job == Job::Enforcer || job.job == Job::Telepath
        { unity: { additive: 1 } }
      else
        {}
      end
    end
  )
end
