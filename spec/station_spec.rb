require "./lib/station"

describe Station do

  it "is created with a name" do
    station = Station.new("Victoria", 1)
    expect(station.name).to eq "Victoria"
  end

  it "is created with a zone" do
    station = Station.new("Victoria", 1)
    expect(station.zone).to eq 1
  end

end