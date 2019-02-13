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
    expect(journey.fare).to eq Journey::MINIMUM_LIMIT
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
end
