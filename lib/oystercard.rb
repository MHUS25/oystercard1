# require "./lib/oystercard"
require "journey"


class Oystercard
  LIMIT = 90
  MINIMUM_FARE = Journey::MINIMUM_FARE
  attr_reader :balance, :entry_station, :exit_station, :journeys


  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    raise("Oystercard limit of #{LIMIT} exceeded") if (balance + amount) > LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise("Insufficient funds, you need at least #{MINIMUM_FARE} pounds to travel") if balance < MINIMUM_FARE
    @current_journey = Journey.new
    @current_journey.begin(station)
  end

  def touch_out(station)
    deduct(@current_journey.fare)
    record_journey # THIS NEEDS TO CHANGE
    @current_journey.end(station)
  end

  def in_journey?
    !!@entry_station
  end

  private

  def record_journey
    @journeys <<
  end

  def deduct(amount)
    @balance -=amount
  end

end
