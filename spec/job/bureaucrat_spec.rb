# frozen_string_literal: true

require_relative '../../lib/civic'
require_relative '../../lib/job'
require_relative '../../lib/pop'

RSpec.describe Job::Bureaucrat do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Bureaucrat')
  end

  it 'produces 4 Unity' do
    expect(job.output).to eq_resources({ unity: 4 })
  end

  it 'requires 2 Consumer Goods' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 2 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_administrator }

  context 'when empire has Byzantine Bureaucracy civic' do
    include_context 'with empire' do
      let(:civics) { [Civic::ByzantineBureaucracy] }
    end

    let(:bureaucrat) { Pop.new(species: species, colony: colony, job: described_class) }

    it 'produces 5 Unity' do
      expect(bureaucrat.job_output).to eq_resources({ unity: 5 })
    end

    it 'provides 1 stability' do
      expect(bureaucrat.stability_modifier).to eq(1)
    end
  end
end
