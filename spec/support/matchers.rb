# frozen_string_literal: true

require 'resource_group'
require 'resource_modifier'

RSpec::Matchers.define :eq_resources do |_expected|
  def expected_resources
    ResourceGroup.new(expected)
  end

  match do |actual|
    @actual = actual.resolve
    actual == expected_resources
  end

  description { 'to equal' }
  failure_message do |actual|
    "\nexpected: #{expected.inspect}\n     got: #{actual.inspect}\n\n(compared using ==)\n"
  end
  failure_message_when_negated do |actual|
    "\nexpected: value != #{expected.inspect}\n     got: #{actual.inspect}\n\n(compared using ==)\n"
  end

  diffable
end

RSpec::Matchers.define :eq_resource_modifier do |_expected|
  def expected_modifier
    ResourceModifier.new(expected)
  end

  match do |actual|
    @actual = actual.values
    actual == expected_modifier
  end

  description { 'to equal' }
  failure_message do |actual|
    "\nexpected: #{expected.inspect}\n     got: #{actual.inspect}\n\n(compared using ==)\n"
  end
  failure_message_when_negated do |actual|
    "\nexpected: value != #{expected.inspect}\n     got: #{actual.inspect}\n\n(compared using ==)\n"
  end

  diffable
end
