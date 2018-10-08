# require "./lib/oystercard"
class Oystercard
  LIMIT = 90
  MINIMUM_FARE = 1
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
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    record_journey
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  private

  def record_journey
    @journeys << {entry: entry_station, exit: exit_station}
  end

  def deduct(amount)
    @balance -=amount
  end

end
