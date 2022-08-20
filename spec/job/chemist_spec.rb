# frozen_string_literal: true

require 'job'

RSpec.describe Job::Chemist do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Chemist')
  end

  it 'produces 2 Volatile Motes' do
    expect(job.output).to eq_resources({ volatile_motes: 2 })
  end

  it 'requires 10 Minerals' do
    expect(job.upkeep).to eq_resources({ minerals: 10 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_chemist }
end
