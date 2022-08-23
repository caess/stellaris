# frozen_string_literal: true

# rubocop:todo Style/Documentation

module ColonyDecision
  module_function

  def lookup(name)
    case name
    when Symbol
      const_get(name.to_s.split('_').map(&:capitalize).join.to_sym)
    when String
      constants.find { |x| x.is_a?(Job) and x.name == name }
    when Modifier
      name
    end
  end
end

# rubocop:enable Style/Documentation

Dir[File.join(__dir__, 'colony_decision', '*.rb')].sort.each { |file| require file }
