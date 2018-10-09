class Journey
  MINIMUM_FARE = 1
  PENALTY = 6

  attr_reader :entry_station, :exit_station

  def initialize(entry_station)
    @entry_station = entry_station
    @complete = false
  end

  def end(station)
    @exit_station = station
    @complete = true
  end

  def fare
    unless @exit_station
      PENALTY
    else
      MINIMUM_FARE
    end
  end

  def complete?
    @complete
  end

  def completed_journey
    {entry: @entry_station, exit: @exit_station}
  end

end
