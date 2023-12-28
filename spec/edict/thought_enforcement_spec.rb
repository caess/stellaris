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
end
