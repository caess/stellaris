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
end
