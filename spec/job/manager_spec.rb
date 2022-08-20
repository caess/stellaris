# frozen_string_literal: true

require 'job'

RSpec.describe Job::Manager do
  subject(:job) { described_class }

  it 'has the correct name' do
    expect(job.name).to eq('Manager')
  end

  it 'produces 4 Unity and 2 Trade' do
    expect(job.output).to eq_resources({ unity: 4, trade: 2 })
  end

  it 'requires 2 Consumer Goods' do
    expect(job.upkeep).to eq_resources({ consumer_goods: 2 })
  end

  it { is_expected.to be_specialist }
  it { is_expected.to be_administrator }
  it { is_expected.to be_manager }
end
