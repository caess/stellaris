# frozen_string_literal: true

require_relative '../job'

class Building
  AlloyFoundries = Building.new(
    name: 'Alloy Foundries',
    max_jobs: { Job::Metallurgist => 2 },
    upkeep: { energy: 2 }
  )
end
