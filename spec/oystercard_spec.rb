require 'oystercard'
require 'pry'

describe Oystercard do
  let (:limit) { Oystercard::LIMIT }
  let (:minimum) { Oystercard::MINIMUM_FARE }
  let (:station_A) { double(:station_A) }
  let (:station_B) { double(:station_B) }

  describe '#balance' do
    it 'returns initial balance 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'it updates balance with amount' do
      expect{ subject.top_up(5) }.to change{ subject.balance }.by 5
    end

    it 'raises error if balance > limit' do
      subject.top_up(limit)
      expect{ subject.top_up(1) }.to raise_error("Oystercard limit of #{limit} exceeded")
    end
  end

    it 'in_journey is initially false' do
      expect(subject.in_journey).to be false
    end

  context "When touching in/out" do
    before { subject.top_up(minimum) }
    before { subject.touch_in(station_A) }

    describe '#touch_in' do
      it 'updates in_journey to true' do
        expect(subject.in_journey).to be true
      end

      it 'raises an error if touching in with balance less than minimum amount' do
        subject.touch_out(station_B)
        expect{ subject.touch_in(station_A) }.to raise_error "Insufficient funds, you need at least #{minimum} pounds to travel"
      end
    end

    describe '#touch_out' do
      before { subject.touch_out(station_B) }

      it 'updates in_journey to false' do
        expect(subject.in_journey).to be false
      end

      it "deducts minimum fare from balance" do
        expect(subject.balance).to eq(0)
      end
    end

    describe '#journeys' do
      it 'starts with no journeys' do
        expect(subject.journeys).to be_empty
      end

      it 'records journeys' do
        subject.touch_in(station_A)
        subject.touch_out(station_B)
        expect(subject.journeys).to include({entry: station_A, exit: station_B})
      end
    end

  end
end
