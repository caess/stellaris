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
    {}
  end

  def upkeep
    {}
  end

  def net_output
    output() - upkeep()
  end
end
