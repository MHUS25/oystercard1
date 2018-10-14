# require "./lib/oystercard"
# require "journey"


class Oystercard
  LIMIT = 90
  MINIMUM_FARE = 1
  PENALTY = 6
  attr_reader :balance, :in_journey, :log
  attr_accessor :current_journey

  def initialize
    @balance = 0
    @in_journey = false
    # @current_journey
    @log = JourneyLog.new
  end

  def top_up(amount)
    raise("Oystercard limit of #{LIMIT} exceeded") if (balance + amount) > LIMIT
    @balance += amount
  end

  def touch_in(station)
    deduct(PENALTY) if in_journey?
    raise("Insufficient funds, you need at least #{MINIMUM_FARE} pounds to travel") if balance < MINIMUM_FARE
    log.start(station)
    log.clear_journey
    @in_journey = true
  end

  def touch_out(station)
    log.end(station)
    deduct(log.current_journey.fare)
    @in_journey = false
    log.clear_journey
  end

  def in_journey?
    @in_journey
  end

  #private


  def deduct(amount)
    @balance -= amount
  end

end
