# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Job::Translucer do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Translucer')
  end

  it 'produces 2 Rare Crystals' do
    expect(job.output).to eq_resources({ rare_crystals: 2 })
  end

  it 'requires 10 Minerals' do
    expect(job.upkeep).to eq_resources({ minerals: 10 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_translucer }
end
