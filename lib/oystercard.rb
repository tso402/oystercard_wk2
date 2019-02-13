class Oystercard
  attr_reader :balance, :in_use, :entry_station, :exit_station, :list_journeys
  MAXIMUM_LIMIT = 90
  MINIMUM_LIMIT = 1

  def initialize
    @balance = 0
    @current_journey = nil
    @list_journeys = []
  end

  def top_up(amount)
    raise "Top-up aborted. Would exceed #{MAXIMUM_LIMIT} limit." if over_limit?(amount)

    @balance += amount
  end

  def in_journey?
    return false unless !@current_journey.nil?

    true
  end

  def touch_in(entry_station)
    raise "Insufficient Funds Available" if under_limit?
    @current_journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    deduct(MINIMUM_LIMIT)
    @current_journey.end(exit_station)
    @list_journeys << @current_journey
    @current_journey = nil
  end

  private

  def over_limit?(amount)
    return false unless (@balance + amount) > MAXIMUM_LIMIT

    true
  end

  def under_limit?
    return false unless @balance < MINIMUM_LIMIT

    true
  end

  def deduct(amount)
    @balance -= amount
  end
end
