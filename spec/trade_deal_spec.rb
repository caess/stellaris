# frozen_string_literal: true

require_relative '../lib/trade_deal'

RSpec.describe TradeDeal do
  subject(:deal) { described_class.new(ours: { consumer_goods: 10 }, theirs: { minerals: 20 }) }

  it 'shows their contribution as output' do
    expect(deal.output).to eq_resources({ minerals: 20 })
  end

  it 'shows our contribution as upkeep' do
    expect(deal.upkeep).to eq_resources({ consumer_goods: 10 })
  end
end
