# frozen_string_literal: true

require 'job'

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
end
