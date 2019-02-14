require_relative '../lib/oystercard'

describe Oystercard do
  it 'has a balance of 0 when newly initialized' do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end

  describe 'top-up' do
    it 'When top up the amount is added to the balance' do
      card = Oystercard.new
      expect { card.top_up(Oystercard::MAXIMUM_LIMIT) }.to change { card.balance }.by Oystercard::MAXIMUM_LIMIT
    end

    it 'cannot be topped up above the limit' do
      card = Oystercard.new
      expect { card.top_up(900) }.to raise_error "Top-up aborted. Would exceed #{Oystercard::MAXIMUM_LIMIT} limit."
    end
  end

  describe 'deduct' do
    it 'reduces the total by an amount when deducted' do
      card = Oystercard.new
      card.top_up(Oystercard::MAXIMUM_LIMIT)
      card.send(:deduct, 40)
      expect{card.send(:deduct, 40)}.to change{card.balance}.by -40
    end
  end

  describe 'in use:' do

    let (:entry_station) { double :entry_station, name: 'Victoria', zone: 1 }
    let (:exit_station) { double :exit_station, name: 'Aldgate', zone: 1 }

    it 'Raises an error if touched in with a balance less than the minimum' do
    expect { subject.touch_in(entry_station) }.to raise_error("Insufficient Funds Available")
    end

    it 'Deducts the journey fare when touched out' do
      journey_log_double = double :journey_log, in_journey?: false, start: nil, finish: 53
      card = Oystercard.new(journey_log_double)
      card.top_up(Oystercard::MAXIMUM_LIMIT)
      card.touch_in(entry_station)
      expect{card.touch_out(exit_station)}.to change{card.balance}.by -(53)
    end

    it 'completes the previous journey if touch in before a touch out' do
      journey_log_double = double :journey_log, in_journey?: true, start: nil, finish: 6
      card = Oystercard.new(journey_log_double)
      card.top_up(20)
      card.touch_in(entry_station)
      expect{ card.touch_in(entry_station) }.to change { card.balance }.by -6
    end

    it "Outputs a list of journeys in a neat way" do
      journey_double = double :journey_doubl, entry_station: entry_station, exit_station: exit_station
      jounrey_log_double = double :journey_Log, in_journey?: false, start: nil, finish: 1 , journeys: [journey_double]
      card = Oystercard.new(jounrey_log_double)
      card.top_up(20)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect{ card.list_journeys }.to output{ "Entry: Victoria Zone 1, Exit: Aldgate Zone 1" }.to_stdout
    end
  end
end
