# require "./lib/oystercard"
class Oystercard
  LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station


  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    raise("Oystercard limit of #{LIMIT} exceeded") if (balance + amount) > LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise("Insufficient funds, you need at least £#{MINIMUM_FARE} to travel") if balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  private

  def deduct(amount)
    @balance -=amount
  end

end
