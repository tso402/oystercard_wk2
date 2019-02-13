class JourneyLog

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station = nil)
    @current_journey = @journey_class.new(station)
  end

  def finish(station = nil)
    @current_journey.end(station)
    @journeys << @current_journey
  end

  def journeys
    @journeys.dup
  end

private

  def current_journey(station = nil)
    return @current_journey unless @current_journey.nil?

    @current_journey = @journey_class.new(station)
  end
end
