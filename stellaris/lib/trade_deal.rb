require_relative "./mixins"
require_relative "./resource_group"

class TradeDeal
  include OutputsResources

  def initialize(us: {}, them: {})
    @our_contribution = ResourceGroup.new(us)
    @their_contribution = ResourceGroup.new(them)
  end

  def output
    @their_contribution.dup
  end

  def upkeep
    @our_contribution.dup
  end
end
