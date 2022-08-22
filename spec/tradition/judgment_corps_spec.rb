# frozen_string_literal: true

require_relative '../../lib/job'
require_relative '../../lib/pop_job'
require_relative '../../lib/tradition'

RSpec.describe Tradition::JudgmentCorps do
  subject(:tradition) { described_class }

  let(:enforcer) { PopJob.new(worker: nil, job: Job::Enforcer) }
  let(:telepath) { PopJob.new(worker: nil, job: Job::Telepath) }

  it 'has the correct name' do
    expect(tradition.name).to eq('Judgment Corps')
  end

  it 'adds 1 Unity to Enforcer output' do
    expect(tradition.job_output_modifiers(enforcer))
      .to eq_resource_modifier({ unity: { additive: 1 } })
  end

  it 'adds 1 Unity to Telepath output' do
    expect(tradition.job_output_modifiers(telepath))
      .to eq_resource_modifier({ unity: { additive: 1 } })
  end

  context 'when applied to an empire' do
    include_context 'with empire' do
      let(:traditions) { [described_class] }
    end

    it 'increases Enforcer Unity output to 1' do
      enforcer = Pop.new(species: species, colony: colony, job: Job::Enforcer)
      colony.add_pop(enforcer)

      expect(enforcer.job_output[:unity]).to eq(1)
    end

    it 'increases Telepath Unity output to 7 (before Telepath 5% resource increase)' do
      telepath = Pop.new(species: species, colony: colony, job: Job::Telepath)
      colony.add_pop(telepath)

      expect(telepath.job_output[:unity]).to be_within(0.01).of(7.35)
    end
  end
end
