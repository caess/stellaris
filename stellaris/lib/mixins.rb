module UsesAmenities
  def amenities_output
    0
  end

  def amenities_upkeep
    0
  end

  def net_amenities
    amenities_output - amenities_upkeep
  end
end

module OutputsResources
  def output
    ResourceGroup.new({})
  end

  def upkeep
    ResourceGroup.new({})
  end

  def net_output
    output() - upkeep()
  end
end
