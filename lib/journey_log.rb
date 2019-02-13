class JourneyLog

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

private

  def current_journey(station = nil)
    return @current_journey unless @current_journey.nil?

    @current_journey = @journey_class.new(station)
  end
end
