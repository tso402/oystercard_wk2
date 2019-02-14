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
    expect(log.send(:current_journey)).to eq(journey_double)
  end

  it "finishes a journey when given a station" do
    station = double :station
    journey_double = double :journey, end: journey_double, fare: 4
    journey_class_double = double :journey_class, new: journey_double
    log = JourneyLog.new(journey_class_double)
    log.start(station)
    log.finish(station)
    expect(log.send(:current_journey)).to eq(journey_double)
  end

  it "should return the current journey when there is an incomplete current journey" do
    station = double :station
    journey_double = double :journey, end: journey_double, fare: 4
    journey_class_double = double :journey_class, new: journey_double
    log = JourneyLog.new(journey_class_double)
    log.start(station)
    expect(log.send(:current_journey)).to eq(journey_double)
  end

  it 'Should return a new journey if no curreny jounrey exists' do
    station = double :station
    journey_double = double :journey, end: journey_double, fare: 4
    journey_class_double = double :journey_class, new: journey_double
    log = JourneyLog.new(journey_class_double)
    expect(log.send(:current_journey, station)).to eq(journey_double)
  end

  it 'Returns a copy of the list of previous journeys' do
    station = double :station
    journey_double = double :journey, end: journey_double, fare: 4
    journey_class_double = double :journey_class, new: journey_double
    log = JourneyLog.new(journey_class_double)
    log.start(station)
    log.finish(station)
    expect(log.journeys).to include(journey_double)
  end

  it 'Returns a copy of the list of previous journeys' do
    log = JourneyLog.new
    expect(log.journeys).to be_empty
  end

  it 'When we have a new journeylog we are not to be in a journey' do
    log = JourneyLog.new
    expect(log.in_journey?).to eq false
  end

  it 'is touched in' do
    station = double :station
    expect { subject.start(station) }.to change { subject.in_journey? }.from(false).to(true)
  end

  it 'Forgets an exit station on touch_in' do
    station = double :station
    log = JourneyLog.new
    log.start(station)
    expect{ log.finish(station) }.to change { log.in_journey? }.from(true).to(false)
  end

  it 'After a journey the journeys list is increased by 1' do
    station = double :station
    journey_double = double :journey, end: journey_double, fare: 4
    journey_class_double = double :journey_class, new: journey_double
    log = JourneyLog.new(journey_class_double)
    log.start(station)
    expect { log.finish(station) }.to change { log.journeys.count }.by 1
  end
end
