# frozen_string_literal: true

require_relative '../job'

module Government
  HiveMind = Modifier.new(
    name: 'Hive Mind',
    job_upkeep_modifiers: lambda do |job|
      if job.job == Job::Necrophyte
        {
          consumer_goods: { additive: -1 },
          food: { multiplicative: 1 },
          minerals: { multiplicative: 1 }
        }
      else
        {}
      end
    end
  )
end
