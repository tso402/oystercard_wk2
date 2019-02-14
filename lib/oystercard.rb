class Oystercard
  attr_reader :balance,:current_journey, :journeyLog
  MAXIMUM_LIMIT = 90
  MINIMUM_LIMIT = 1

  def initialize(journeyLog = JourneyLog.new)
    @balance = 0
    @journeyLog = journeyLog
  end

  def top_up(amount)
    raise "Top-up aborted. Would exceed #{MAXIMUM_LIMIT} limit." if over_limit?(amount)

    @balance += amount
  end

  def touch_in(entry_station)
    touch_out() if @journeyLog.in_journey?
    raise "Insufficient Funds Available" if under_limit?
    @journeyLog.start(entry_station)
  end

  def touch_out(exit_station = nil)
    deduct(@journeyLog.finish(exit_station))
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
