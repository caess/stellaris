require_relative '../stellaris/lib/stellaris'

RSpec.describe 'districts' do
  context 'normal planets' do
    describe 'city districts' do
      subject {District::CityDistrict}

      it 'has the correct name' do
        expect(subject.name).to eq('City District')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(5)
      end

      it 'has the correct colony attribute modifier' do
        expect(subject.colony_attribute_modifiers).to eq(ResourceModifier.new({
          building_slot: {additive: 1},
        }))
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({
          Job::Clerk => 1,
        })
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
      end
    end

    describe 'industrial districts' do
      subject {District::IndustrialDistrict}

      it 'has the correct name' do
        expect(subject.name).to eq('Industrial District')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(2)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({
          Job::Metallurgist => 1,
          Job::Artisan => 1,
        })
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
      end
    end

    describe 'trade districts' do
      subject {District::TradeDistrict}

      it 'has the correct name' do
        expect(subject.name).to eq('Trade District')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(2)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({
          Job::Artisan => 1,
          Job::Clerk => 1,
        })
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
      end
    end

    describe 'generator districts' do
      subject {District::GeneratorDistrict}

      it 'has the correct name' do
        expect(subject.name).to eq('Generator District')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(2)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({Job::Technician => 2})
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({energy: 1}))
      end
    end

    describe 'mining districts' do
      subject {District::MiningDistrict}

      it 'has the correct name' do
        expect(subject.name).to eq('Mining District')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(2)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({Job::Miner => 2})
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({energy: 1}))
      end
    end

    describe 'agriculture districts' do
      subject {District::AgricultureDistrict}

      it 'has the correct name' do
        expect(subject.name).to eq('Agriculture District')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(2)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({Job::Farmer => 2})
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({energy: 1}))
      end
    end
  end

  context 'habitats' do
    describe 'habitation districts' do
      subject {District::HabitationDistrict}

      it 'has the correct name' do
        expect(subject.name).to eq('Habitation District')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(8)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({})
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
      end
    end

    describe 'industrial districts' do
      subject {District::HabitatIndustrialDistrict}

      it 'has the correct name' do
        expect(subject.name).to eq('Industrial District (Habitat)')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(3)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({
          Job::Artisan => 1,
          Job::Metallurgist => 1,
        })
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
      end
    end

    describe 'trade districts' do
      subject {District::HabitatTradeDistrict}

      it 'has the correct name' do
        expect(subject.name).to eq('Trade District (Habitat)')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(3)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({
          Job::Clerk => 3,
        })
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
      end
    end

    describe 'reactor districts' do
      subject {District::ReactorDistrict}

      it 'has the correct name' do
        expect(subject.name).to eq('Reactor District')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(3)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({
          Job::Technician => 3,
        })
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
      end
    end

    describe 'leisure districts' do
      subject {District::LeisureDistrict}

      it 'has the correct name' do
        expect(subject.name).to eq('Leisure District')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(3)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({
          Job::Entertainer => 3,
        })
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
      end
    end

    describe 'research districts' do
      subject {District::ResearchDistrict}

      it 'has the correct name' do
        expect(subject.name).to eq('Research District')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(3)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({
          Job::Researcher => 3,
        })
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
      end
    end

    describe 'astro-mining bays' do
      subject {District::AstroMiningBay}

      it 'has the correct name' do
        expect(subject.name).to eq('Astro-Mining Bay')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(3)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({
          Job::Miner => 3,
        })
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({energy: 2}))
      end
    end
  end

  context 'ecumenopolis districts' do
    describe 'residential arcologies' do
      subject {District::ResidentialArcology}

      it 'has the correct name' do
        expect(subject.name).to eq('Residential Arcology')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(15)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({
          Job::Clerk => 3,
        })
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({energy: 5}))
      end
    end

    describe 'foundry arcologies' do
      subject {District::FoundryArcology}

      it 'has the correct name' do
        expect(subject.name).to eq('Foundry Arcology')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(10)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({
          Job::Metallurgist => 6,
        })
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({
          energy: 5,
          volatile_motes: 1,
        }))
      end
    end

    describe 'industrial arcologies' do
      subject {District::IndustrialArcology}

      it 'has the correct name' do
        expect(subject.name).to eq('Industrial Arcology')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(10)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({
          Job::Artisan => 6,
        })
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({
          energy: 5,
          rare_crystals: 1,
        }))
      end
    end

    describe 'leisure arcologies' do
      subject {District::LeisureArcology}

      it 'has the correct name' do
        expect(subject.name).to eq('Leisure Arcology')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(10)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({
          Job::Entertainer => 6,
        })
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({
          energy: 5,
          exotic_gases: 1,
        }))
      end
    end

    describe 'administrative arcologies' do
      subject {District::AdministrativeArcology}

      it 'has the correct name' do
        expect(subject.name).to eq('Administrative Arcology')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(10)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({
          Job::Bureaucrat => 6,
        })
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({
          energy: 5,
          rare_crystals: 1,
        }))
      end
    end

    describe 'ecclesiastical arcologies' do
      subject {District::EcclesiasticalArcology}

      it 'has the correct name' do
        expect(subject.name).to eq('Ecclesiastical Arcology')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(10)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({
          Job::Priest => 6,
        })
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({
          energy: 5,
          rare_crystals: 1,
        }))
      end
    end
  end

  context 'ring world segments' do
    describe 'city segment' do
      subject {District::CitySegment}

      it 'has the correct name' do
        expect(subject.name).to eq('City Segment')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(25)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({
          Job::Clerk => 3,
          Job::Enforcer => 2,
        })
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({energy: 5}))
      end
    end

    describe 'industrial segment' do
      subject {District::IndustrialSegment}

      it 'has the correct name' do
        expect(subject.name).to eq('Industrial Segment')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(10)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({
          Job::Artisan => 5,
          Job::Metallurgist => 5,
        })
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({
          energy: 5,
          volatile_motes: 2,
        }))
      end
    end

    describe 'commercial segment' do
      subject {District::CommercialSegment}

      it 'has the correct name' do
        expect(subject.name).to eq('Commercial Segment')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(10)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({
          Job::Merchant => 2,
          Job::Clerk => 6,
        })
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({
          energy: 5,
          rare_crystals: 2,
        }))
      end
    end

    describe 'generator segment' do
      subject {District::GeneratorSegment}

      it 'has the correct name' do
        expect(subject.name).to eq('Generator Segment')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(10)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({Job::Technician => 10})
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({
          energy: 5,
          rare_crystals: 2,
        }))
      end
    end

    describe 'research segment' do
      subject {District::ResearchSegment}

      it 'has the correct name' do
        expect(subject.name).to eq('Research Segment')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(10)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({Job::Researcher => 10})
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({
          energy: 5,
          exotic_gases: 2,
        }))
      end
    end

    describe 'agricultural segment' do
      subject {District::AgriculturalSegment}

      it 'has the correct name' do
        expect(subject.name).to eq('Agricultural Segment')
      end

      it 'has the correct housing' do
        expect(subject.housing).to eq(10)
      end

      it 'has the correct max jobs' do
        expect(subject.max_jobs).to eq({Job::Farmer => 10})
      end

      it 'has the correct upkeep' do
        expect(subject.upkeep).to eq(ResourceGroup.new({
          energy: 5,
          volatile_motes: 2,
        }))
      end
    end
  end
end