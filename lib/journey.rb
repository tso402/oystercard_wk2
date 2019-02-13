class Journey
  attr_reader :entry_station, :exit_station
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(station = nil)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
  end

  def fare
    return MINIMUM_FARE unless @exit_station.nil? || @entry_station.nil?

    PENALTY_FARE
  end
end
