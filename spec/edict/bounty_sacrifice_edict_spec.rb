# frozen_string_literal: true

require_relative '../../lib/edict'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe Edict::BountySacrificeEdict do
  subject(:edict) { described_class }

  it 'has the correct name' do
    expect(edict.name).to eq('Bounty Sacrifice Edict')
  end

  it 'adds 3 Unity to the output for Death Priests' do
    death_priest = PopJob.new(worker: nil, job: Job::DeathPriest)

    expect(edict.job_output_modifiers(death_priest))
      .to eq_resource_modifier({ unity: { additive: 3 } })
  end

  context 'when enacted' do
    include_context 'with empire' do
      let(:edicts) { [described_class] }
    end

    let(:death_priest) { Pop.new(species: species, colony: colony, job: Job::DeathPriest) }

    it 'increases the output of Death Priests to 6 Unity and 1 Society Research' do
      expect(death_priest.job_output).to eq_resources({ unity: 6, society_research: 1 })
    end
  end
end
