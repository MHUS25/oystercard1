require 'oystercard'

describe Oystercard do
  let (:limit) { Oystercard::LIMIT }
  let (:minimum) { Oystercard::MINIMUM_FARE }

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

  describe '#deduct' do
    it 'decreases balance by amount' do
      subject.top_up(10)
      expect{ subject.deduct(5) }.to change{ subject.balance }.by -5
    end
  end

  describe '#in_journey?' do
    it 'is initially false' do
      expect(subject).not_to be_in_journey
    end
  end

  context "When touching in/out" do
    before { subject.top_up(minimum) }

    describe '#touch_in' do
      it 'updates in_journey to true' do
        subject.touch_in
        expect(subject).to be_in_journey
      end

      it 'raises an error if balance is less than minimum amount' do
        subject.deduct(minimum)
        expect{ subject.touch_in }.to raise_error "Insufficient funds, you need at least £#{minimum} to travel"
      end
    end

    describe '#touch_out' do
      it 'updates in_journey to false' do
        subject.touch_in
        subject.touch_out
        expect(subject).not_to be_in_journey
      end
    end
  end
end
