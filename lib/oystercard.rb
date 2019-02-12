class Oystercard
  attr_reader :balance, :in_use, :entry_station
  MAXIMUM_LIMIT = 90
  MINIMUM_LIMIT = 1

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    raise "Top-up aborted. Would exceed #{MAXIMUM_LIMIT} limit." if over_limit?(amount)

    @balance += amount
  end

  def in_journey?
    return false unless !@entry_station.nil?

    true
  end

  def touch_in(entry_station)
    raise "Insufficient Funds Available" if under_limit?
    @entry_station = entry_station
  end

  def touch_out
    deduct(MINIMUM_LIMIT)
    @entry_station = nil
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
