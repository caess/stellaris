# frozen_string_literal: true

require_relative '../../lib/edict'
require_relative '../../lib/job'
require_relative '../../lib/pop'

RSpec.describe Job::Researcher do
  subject(:job) { described_class }

  let(:expected_output) do
    {
      physics_research: 4,
      society_research: 4,
      engineering_research: 4
    }
  end

  it 'has the correct name' do
    expect(job.name).to eq('Researcher')
  end

  it 'produces 6 Research' do
    expect(job.output).to eq_resources(expected_output)
  end

  it 'requires 2 Consumer Goods' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 2 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_researcher }

  context 'when empire has Research Subsidies edict' do
    include_context 'with empire' do
      let(:edicts) { [Edict::ResearchSubsidies] }
    end

    let(:researcher) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'requires 2 Consumer Goods and 1 Energy' do
      expect(researcher.job_upkeep).to eq_resources({ consumer_goods: 2, energy: 1 })
    end
  end
end
