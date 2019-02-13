require 'journey_log'

describe JourneyLog do
  # let (:station) { double :station }
  # let (:journey_double) {double :journey, end: journey_double, fare: 8}
  # let (:journey_class_double) {double :journey_class, new: journey_double}

  it "starts a new journey when given a station" do
    station = double :station
    journey_double = double :journey, end: journey_double, fare: 4
    journey_class_double = double :journey_class, new: journey_double
    log = JourneyLog.new(journey_class_double)
    log.start(station)
    expect(log.current_journey).to eq(journey_double)
  end

  it "finishes a journey when given a station" do
    station = double :station
    journey_double = double :journey, end: journey_double, fare: 4
    journey_class_double = double :journey_class, new: journey_double
    log = JourneyLog.new(journey_class_double)
    log.start(station)
    log.finish(station)
    expect(log.current_journey).to eq(nil)
  end

end
