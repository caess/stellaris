# frozen_string_literal: true

require_relative '../../lib/government'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'
require_relative '../../lib/species_trait'

RSpec.describe Government::HiveMind do
  subject(:government) { described_class }

  let(:expected_necrophyte_upkeep_modifier) do
    {
      consumer_goods: { additive: -1 },
      food: { multiplicative: 1 },
      minerals: { multiplicative: 1 }
    }
  end

  it 'has the correct name' do
    expect(government.name).to eq('Hive Mind')
  end

  it 'replaces the Consumer Goods in the Necrophyte job with additional pop upkeep' do
    necrophyte = PopJob.new(worker: nil, job: Job::Necrophyte)

    expect(government.job_upkeep_modifiers(necrophyte))
      .to eq_resource_modifier(expected_necrophyte_upkeep_modifier)
  end
end
