require './lib/journey.rb'
describe Journey do
  it 'Stores entry_station when touched in' do
    station = double :station
    journey = Journey.new(station)
    expect(journey.entry_station).to eq station
  end

  it "stores the exit station at the end of a journey" do
    station = double :station
    journey = Journey.new(station)
    journey.end(station)
    expect(journey.exit_station).to eq(station)
  end

  it 'returns a fare' do
    station = double :station
    journey = Journey.new(station)
    journey.end(station)
    expect(journey.fare).to eq Journey::MINIMUM_FARE
  end

  it "returns penalty fare if no exit station" do
    station = double :station
    journey = Journey.new(station)
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  it 'Returns a penalty fare if no entry station' do
    station = double :station
    journey = Journey.new()
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  context "Charges a fare for going between stations" do
    let(:station) {double :station}
    let(:other_station) {double :other_station}
    it "of 1 for zone 1 to zone 1" do
      zones(1,1)
      trip = Journey.new(station)
      trip.end(other_station)
      expect(trip.fare).to eq 1
    end
    it "of 2 for zone 2 to zone 1" do
      zones(2,1)
      trip = Journey.new(station)
      trip.end(other_station)
      expect(trip.fare).to eq 2
    end
    it "of 3 for zone 5 to zone 2" do
      zones(5,2)
      trip = Journey.new(station)
      trip.end(other_station)
      expect(trip.fare).to eq 3
    end
    it "of 4 for zone 2 to zone 6" do
      zones(2,6)
      trip = Journey.new(station)
      trip.end(other_station)
      expect(trip.fare).to eq 4
    end
    it "of 1 for zone 2 to zone 2" do
      zones(2,2)
      trip = Journey.new(station)
      trip.end(other_station)
      expect(trip.fare).to eq 2
    end

    def zones(entry, exit)
      allow(station).to receive(:zone).and_return(entry)
      allow(other_station). to receive(:zone).and_return(exit)
    end
  end

end
