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
    expect(journey.fare).to eq MINIMUM_LIMIT
  end
end
