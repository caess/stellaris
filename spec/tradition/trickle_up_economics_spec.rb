# frozen_string_literal: true

require_relative '../../lib/job'
require_relative '../../lib/pop_job'
require_relative '../../lib/tradition'

RSpec.describe Tradition::TrickleUpEconomics do
  subject(:tradition) { described_class }

  let(:clerk) { PopJob.new(worker: nil, job: Job::Clerk) }

  it 'has the correct name' do
    expect(tradition.name).to eq('Trickle Up Economics')
  end

  it 'adds trade to Clerk output' do
    expect(tradition.job_output_modifiers(clerk)).to eq_resource_modifier({ trade: { additive: 1 } })
  end
end
