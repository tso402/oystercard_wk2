class Journey
  attr_reader :entry_station, :exit_station
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(station = nil)
    @entry_station = station
  end

  def end(station = nil)
    @exit_station = station
  end

  def fare
    return MINIMUM_FARE + zone_diff unless @exit_station.nil? || @entry_station.nil?

    PENALTY_FARE
  end

private
  def zone_diff
    (@entry_station.zone - @exit_station.zone).abs
  end
end
