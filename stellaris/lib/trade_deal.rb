# frozen_string_literal: true

require_relative './mixins'
require_relative './resource_group'

# rubocop:todo Style/Documentation

class TradeDeal
  include OutputsResources

  def initialize(ours: {}, theirs: {})
    @our_contribution = ours.dup.freeze
    @their_contribution = theirs.dup.freeze
  end

  def output
    ResourceGroup.new(@their_contribution)
  end

  def upkeep
    ResourceGroup.new(@our_contribution)
  end
end

# rubocop:enable Style/Documentation
