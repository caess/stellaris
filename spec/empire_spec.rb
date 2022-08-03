require_relative '../stellaris/lib/stellaris'

RSpec.describe Empire do
  let(:ruler) {Leader.new(level: 2)}
  let(:species) {Species.new(traits: [], living_standard: :decent_conditions)}
  subject {
    Empire.new(
      founding_species: species,
      ruler: ruler,
      ethics: [],
      civics: [],
    )
  }

  describe 'stations' do
    it 'includes mining stations in its output' do
      station = MiningStation.new({minerals: 10})
      subject.add_station(station)
      expect(subject.output).to eq(ResourceGroup.new({minerals: 10}))
    end

    it 'includes mining stations in its upkeep' do
      station = MiningStation.new({minerals: 10})
      subject.add_station(station)
      expect(subject.upkeep).to eq(ResourceGroup.new({energy: 1}))
    end

    it 'includes research stations in its output' do
      station = ResearchStation.new({physics_research: 10})
      subject.add_station(station)
      expect(subject.output).to eq(ResourceGroup.new({physics_research: 10}))
    end

    it 'includes research stations in its upkeep' do
      station = ResearchStation.new({physics_research: 10})
      subject.add_station(station)
      expect(subject.upkeep).to eq(ResourceGroup.new({energy: 1}))
    end
  end
end