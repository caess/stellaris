# frozen_string_literal: true

require_relative './mixins'
require_relative './resource_group'
require_relative './resource_modifier'

# rubocop:todo Style/Documentation

class Station
  attr_accessor :empire

  def initialize(output = {})
    @empire = nil
    @output = ResourceGroup.new(output)
  end

  def output
    @output.dup
  end

  def upkeep
    ResourceGroup.new({ energy: 1 })
  end
end

# rubocop:enable Style/Documentation
