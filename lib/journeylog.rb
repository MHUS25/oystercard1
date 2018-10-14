class JourneyLog

  attr_reader :journey_class

  def initialize(journey_class=Journey)
    @journeys = []
    @journey_class = journey_class
  end

  def journeys
    @journeys.dup
  end

  def start(station)
    current_journey.start(station)
  end

  def end(station)
    current_journey.end(station)
    record_journey
  end

  def record_journey
     @journeys << current_journey.completed_journey
  end

  def clear_journey
     @current_journey = nil
   end

  #private

  def current_journey
    @current_journey ||= @journey_class.new
  end


end
