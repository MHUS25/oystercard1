class Journey
  MINIMUM_FARE = 1
  PENALTY = 6

  attr_reader :entry_station, :exit_station


  def start(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
  end


  def complete?
  !!(@entry_station && @exit_station)
  end

  def completed_journey
    {entry: @entry_station, exit: @exit_station}
  end

  def fare
    if complete?
      calculate_fare
    else
      PENALTY
    end
  end


   #private

  def calculate_fare
   1 + (@entry_station.zone - @exit_station.zone).abs
  end

end
