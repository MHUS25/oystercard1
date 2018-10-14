require 'oystercard'
require 'pry'

describe Oystercard do
  let (:limit) { Oystercard::LIMIT }
  let (:minimum) { Oystercard::MINIMUM_FARE }
  let (:penalty) { Oystercard::PENALTY }
  let (:station_A) { double(:station_A) }
  let (:station_B) { double(:station_B) }

  let (:journey) { double(:journey, fare: minimum, entry_station: "station_A", exit_station: "station_B") }
  let (:log) { double(:log, start: true, finish: true, current_journey: journey, clear_journey: true)}

  describe '#balance' do
    it 'returns initial balance 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'it updates balance with amount' do
      expect{ subject.top_up(minimum) }.to change{ subject.balance }.by minimum
    end

    it 'raises error if balance > limit' do
      subject.top_up(limit)
      expect{ subject.top_up(1) }.to raise_error("Oystercard limit of #{limit} exceeded")
    end
  end

    it 'in_journey is initially false' do
      expect(subject.in_journey).to be false
    end


    describe '#touch_in' do
      it 'updates in_journey to true' do
        subject.top_up(minimum)
        subject.touch_in(station_A)
        expect(subject.in_journey?).to be true
      end

      it 'raises an error if touching in with balance less than minimum amount' do
        subject.top_up(minimum)
        subject.touch_in(station_A)
        subject.touch_out(station_B)
        expect{ subject.touch_in(station_A) }.to raise_error "Insufficient funds, you need at least #{minimum} pounds to travel"
      end
    end

    describe '#touch_out' do
      it 'updates in_journey to false' do
        subject.top_up(minimum)
        subject.touch_in(station_A)
        subject.touch_out(station_B)
        expect(subject.in_journey).to be false
      end

      it "deducts minimum fare from balance" do
        subject.top_up(minimum)
        subject.touch_in(station_A)
        subject.touch_out(station_B)
        expect(subject.balance).to eq(0)
      end

      it "charge penalty fare when touching out but haven't touched in" do
        subject.top_up(minimum)
        allow(journey).to receive(:fare).and_return(penalty)
        expect { subject.touch_out(station_B) }.to change { subject.balance }.by(-penalty)
      end
    end
end
