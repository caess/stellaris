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
end
