# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe Civic::PoliceState do
  subject(:civic) { described_class }

  it 'has the correct name' do
    expect(civic.name).to eq('Police State')
  end

  it 'adds 1 Unity to Enforcer output' do
    enforcer = PopJob.new(worker: nil, job: Job::Enforcer)

    expect(civic.job_output_modifiers(enforcer))
      .to eq_resource_modifier({ unity: { additive: 1 } })
  end

  it 'adds 1 Unity to Telepath output' do
    telepath = PopJob.new(worker: nil, job: Job::Enforcer)

    expect(civic.job_output_modifiers(telepath))
      .to eq_resource_modifier({ unity: { additive: 1 } })
  end

  context 'when chosen for empire' do
    include_context 'with empire' do
      let(:civics) { [described_class] }
    end

    let(:enforcer) { Pop.new(species: species, colony: colony, job: Job::Enforcer) }
    let(:telepath) { Pop.new(species: species, colony: colony, job: Job::Telepath) }

    it 'adds 1 Unity to the output of Enforcers' do
      expect(enforcer.job_output[:unity]).to eq(1)
    end

    it 'increases the base Unity output of Telepaths to 7' do
      expect(telepath.job_output[:unity]).to eq(7)
    end
  end
end
