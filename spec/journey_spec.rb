require './lib/journey.rb'
describe Journey do
  it 'Stores entry_station when touched in' do
    station = double :station
    journey = Journey.new(station)
    expect(journey.entry_station).to eq station
  end
end
