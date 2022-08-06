require_relative '../stellaris/lib/stellaris'

RSpec.describe 'trade deals' do
  subject { TradeDeal.new(us: {consumer_goods: 10}, them: {minerals: 20})}

  it 'shows their contribution as output' do
    expect(subject.output).to eq(ResourceGroup.new({minerals: 20}))
  end

  it 'shows our contribution as upkeep' do
    expect(subject.upkeep).to eq(ResourceGroup.new({consumer_goods: 10}))
  end
end