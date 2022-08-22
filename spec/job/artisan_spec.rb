# frozen_string_literal: true

require_relative '../../lib/job'

RSpec.describe Job::Artisan do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Artisan')
  end

  it 'produces 6 Consumer Goods' do
    expect(job.output).to eq_resources({ consumer_goods: 6 })
  end

  it 'requires 6 Minerals' do
    expect(job.upkeep).to eq_resources({ minerals: 6 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_artisan }
end
