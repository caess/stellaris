# frozen_string_literal: true

require_relative '../../lib/edict'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe Edict::ThoughtEnforcement do
  subject(:edict) { described_class }

  it 'has the correct name' do
    expect(edict.name).to eq('Thought Enforcement')
  end

  it 'increases the crime reduction for Telepaths by 5' do
    telepath = PopJob.new(worker: nil, job: Job::Telepath)

    expect(edict.job_colony_attribute_modifiers(telepath))
      .to eq_resource_modifier({ crime: { additive: -5 } })
  end

  context 'when enacted' do
    include_context 'with empire' do
      let(:edicts) { [described_class] }
    end

    let(:telepath) { Pop.new(species: species, colony: colony, job: Job::Telepath) }

    it 'increases the crime reduction of Telepaths to 40' do
      expect(telepath.colony_attribute_modifiers).to eq_resource_modifier({ crime: { additive: -40 } })
    end
  end
end
