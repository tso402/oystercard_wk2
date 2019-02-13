class JourneyLog
  attr_reader :current_journey

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station = nil)
    @current_journey = @journey_class.new(station)
  end

  def finish(station = nil)
    @journeys << @current_journey.end(station)
  end
end
