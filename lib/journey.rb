class Journey
  attr_reader :entry_station, :exit_station
  MINIMUM_LIMIT = 1

  def initialize(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
  end

  def fare
    MINIMUM_LIMIT
  end
end
