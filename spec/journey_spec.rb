require './lib/journey.rb'
describe Journey do
  let(:station) {double :station}
  let(:other_station) {double :other_station}

  before :each do
    @journey = Journey.new(station)
  end

  it 'Stores entry_station when touched in' do
    expect(@journey.entry_station).to eq station
  end

  it "stores the exit station at the end of a journey" do
    @journey.end(station)
    expect(@journey.exit_station).to eq(station)
  end

  it "returns penalty fare if no exit station" do
    expect(@journey.fare).to eq Journey::PENALTY_FARE
  end

  it 'Returns a penalty fare if no entry station' do
    journey = Journey.new()
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  context "Charges a fare for going between stations" do
    before :each do
      @journey.end(other_station)
    end
    it "of 1 for zone 1 to zone 1" do
      zones(1,1)
      expect(@journey.fare).to eq 1
    end
    it "of 2 for zone 2 to zone 1" do
      zones(2,1)
      expect(@journey.fare).to eq 2
    end
    it "of 4 for zone 5 to zone 2" do
      zones(5,2)
      expect(@journey.fare).to eq 4
    end
    it "of 5 for zone 2 to zone 6" do
      zones(2,6)
      expect(@journey.fare).to eq 5
    end
    it "of 1 for zone 2 to zone 2" do
      zones(2,2)
      expect(@journey.fare).to eq 1
    end

    def zones(entry, exit)
      allow(station).to receive(:zone).and_return(entry)
      allow(other_station). to receive(:zone).and_return(exit)
    end
  end
end
