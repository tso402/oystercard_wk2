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

    let (:entry_station) { double :entry_station }
    let (:exit_station) { double :exit_station }

    it 'the Oystercard is not in use' do
      expect(subject.in_journey?).to eq false
    end

    it 'is touched in' do
      subject.top_up(Oystercard::MAXIMUM_LIMIT)
      expect { subject.touch_in(entry_station) }.to change { subject.in_journey? }.from(false).to(true)
    end

    it 'is touched in and shows as in use' do
      subject.top_up(Oystercard::MAXIMUM_LIMIT)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end

    it "creates and saves a new journey on touch in" do
      journey_double = double :journey
      journey_class_double = double :journey_class, new: journey_double
      card = Oystercard.new(journey_class_double)
      card.top_up(10)
      card.touch_in(entry_station)
      expect(card.current_journey).to eq journey_double
    end

    it 'Forgets an exit station on touch_in' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      expect{ subject.touch_out(exit_station) }.to change { subject.current_journey }.to(nil)
    end

    it 'is touched out' do
      subject.top_up(Oystercard::MAXIMUM_LIMIT)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change { subject.in_journey? }.from(true).to(false)
    end

    it 'is touched out and no longer shows as in use' do
      subject.top_up(Oystercard::MAXIMUM_LIMIT)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to eq false
    end

    it 'Raises an error if touched in with a balance less than the minimum' do
    expect { subject.touch_in(entry_station) }.to raise_error("Insufficient Funds Available")
    end

    it 'Deducts the journey fare when touched out' do
      journey_double = double :journey, end: journey_double, fare: 53
      journey_class_double = double :journey_class, new: journey_double
      card = Oystercard.new(journey_class_double)
      card.top_up(Oystercard::MAXIMUM_LIMIT)
      card.touch_in(entry_station)
      expect{card.touch_out(exit_station)}.to change{card.balance}.by -(53)
    end

    it 'A list of journeys contains the journey after touch_out' do
      journey_double = double :journey, end: journey_double
      journey_class_double = double :journey_class, new: journey_double
      card = Oystercard.new(journey_class_double)
      card.top_up(10)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.list_journeys).to include(journey_double)
    end

    it 'Is created with a blank list of journeys' do
    expect(subject.list_journeys.empty?).to be true
    end

    it 'After tapping out only 1 journey is added' do
      card = Oystercard.new
      card.top_up(10)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.list_journeys.count).to eq 1
    end
  end
end
