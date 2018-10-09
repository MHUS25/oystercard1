class Journey
  MINIMUM_FARE = 1
  PENALTY = 6

  attr_reader :completed_journey

  def start(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
  end

  def fare
    if complete?
      MINIMUM_FARE
    else
      PENALTY
    end
  end

  def complete?
  !!(@entry_station && @exit_station)
  end

  def completed_journey
    {entry: @entry_station, exit: @exit_station}
  end

end
