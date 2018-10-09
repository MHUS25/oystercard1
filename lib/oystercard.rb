# require "./lib/oystercard"
#require "journey"


class Oystercard
  LIMIT = 90
  MINIMUM_FARE = Journey::MINIMUM_FARE
  attr_reader :balance, :entry_station, :exit_station, :journeys, :in_journey


  def initialize
    @balance = 0
    @journeys = []
    @in_journey = false
  end

  def top_up(amount)
    raise("Oystercard limit of #{LIMIT} exceeded") if (balance + amount) > LIMIT
    @balance += amount
  end

  def touch_in(station)
    #add tests functionality to prevent touching in again if in_journey
    raise("Insufficient funds, you need at least #{MINIMUM_FARE} pounds to travel") if balance < MINIMUM_FARE
    @current_journey = Journey.new(station)
    @in_journey = true
  end

  def touch_out(station)
    #add tests functionality to prevent touching out if not in_journey
    @current_journey.end(station)
    deduct(@current_journey.fare)
    record_journey
    @in_journey = false
  end

  private

  def record_journey
     @journeys << @current_journey.completed_journey
  end

  def deduct(amount)
    @balance -=amount
  end

end
