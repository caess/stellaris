require_relative '../stellaris/lib/stellaris'

RSpec.describe 'mining stations' do
  subject { MiningStation.new({minerals: 10})}

  it 'outputs its resources' do
    expect(subject.output).to eq(ResourceGroup.new({minerals: 10}))
  end

  it 'has its upkeep' do
    expect(subject.upkeep).to eq(ResourceGroup.new({energy: 1}))
  end

  it 'has its output modified by the empire' do
    empire = Object.new
    class << empire
      def mining_station_modifiers
        ResourceModifier.new({minerals: {multiplicative: 0.1}})
      end
    end

    subject.empire = empire

    expect(subject.output).to eq(ResourceGroup.new({minerals: 11}))
  end

  describe 'energy stations' do
    subject { MiningStation.new({energy: 10})}

    it 'has no upkeep' do
      expect(subject.upkeep).to eq(ResourceGroup.new({energy: 0}))
    end
  end
end

RSpec.describe 'research stations' do
  subject { ResearchStation.new({physics_research: 10})}

  it 'outputs its resources' do
    expect(subject.output).to eq(ResourceGroup.new({physics_research: 10}))
  end

  it 'has its upkeep' do
    expect(subject.upkeep).to eq(ResourceGroup.new({energy: 1}))
  end

  it 'has its output modified by the empire' do
    empire = Object.new
    class << empire
      def research_station_modifiers
        ResourceModifier.new({physics_research: {multiplicative: 0.1}})
      end
    end

    subject.empire = empire

    expect(subject.output).to eq(ResourceGroup.new({physics_research: 11}))
  end
end