class Journey
  attr_reader :entry_station, :exit_station
  MINIMUM_LIMIT = 1
  PENALTY_FARE = 6

  def initialize(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
  end

  def fare
    return MINIMUM_LIMIT unless @exit_station.nil?

    PENALTY_FARE
  end
end
