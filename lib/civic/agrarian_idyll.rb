# frozen_string_literal: true

require_relative '../job'
require_relative '../modifier'

module Civic
  AgrarianIdyll = Modifier.new(
    name: 'Agrarian Idyll',
    job_amenities_output_modifier:
      ->(job) { job.job == Job::Farmer ? 2 : 0 }
  )
end
