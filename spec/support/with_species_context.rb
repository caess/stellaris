# frozen_string_literal: true

require_relative '../../lib/species'

RSpec.shared_context 'with species' do
  let(:traits) { [] }
  let(:living_standard) { nil }
  let(:species) do
    Species.new(
      living_standard: living_standard,
      traits: traits
    )
  end
end
