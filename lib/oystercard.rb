# require "./lib/oystercard"
require "journey"


class Oystercard
  LIMIT = 90
  MINIMUM_FARE = Journey::MINIMUM_FARE
  PENALTY = Journey::PENALTY
  attr_reader :balance, :journeys, :in_journey
  attr_accessor :current_journey


  def initialize
    @balance = 0
    @journeys = []
    @in_journey = false
    @current_journey
  end

  def top_up(amount)
    raise("Oystercard limit of #{LIMIT} exceeded") if (balance + amount) > LIMIT
    @balance += amount
  end

  def touch_in(station)
    deduct(PENALTY) if in_journey == true
    raise("Insufficient funds, you need at least #{MINIMUM_FARE} pounds to travel") if balance < MINIMUM_FARE
    @current_journey = Journey.new
    @current_journey.start(station)
    @in_journey = true
  end

  def touch_out(station)
    @current_journey ||= Journey.new
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
