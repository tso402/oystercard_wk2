class Oystercard
  attr_reader :balance,:current_journey, :list_journeys
  MAXIMUM_LIMIT = 90
  MINIMUM_LIMIT = 1

  def initialize(journey_class = Journey)
    @balance = 0
    @list_journeys = []
    @journey_class = journey_class
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
    touch_out() if !@current_journey.nil?
    raise "Insufficient Funds Available" if under_limit?
    @current_journey = @journey_class.new(entry_station)
  end

  def touch_out(exit_station = nil)
    @current_journey = @journey_class.new if @current_journey.nil?
    @current_journey.end(exit_station)
    @list_journeys << @current_journey
    deduct(@current_journey.fare)
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
