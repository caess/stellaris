# frozen_string_literal: true

require_relative '../../lib/edict'
require_relative '../../lib/job'
require_relative '../../lib/pop_job'

RSpec.describe Edict::ResearchSubsidies do
  subject(:edict) { described_class }

  it 'has the correct name' do
    expect(edict.name).to eq('Research Subsidies')
  end

  it 'adds 1 Energy to the upkeep for Researchers' do
    researcher = PopJob.new(worker: nil, job: Job::Researcher)

    expect(edict.job_upkeep_modifiers(researcher))
      .to eq_resource_modifier({ energy: { additive: 1 } })
  end
end
