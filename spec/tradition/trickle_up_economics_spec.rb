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

  context 'when applied to an empire' do
    include_context 'default empire' do
      let(:traditions) { [described_class] }
    end

    it 'modifies the output of Clerks' do
      clerk = Pop.new(species: species, colony: colony, job: Job::Clerk)

      expect(clerk.job_output[:trade]).to eq(5)
    end
  end
end
