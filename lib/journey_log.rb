class JourneyLog
  attr_reader :current_journey

  def initialize(journey_class = Journey)
    @journey_class = journey_class
  end

  def start(station = nil)
    @current_journey = @journey_class.new(station)
  end
end
