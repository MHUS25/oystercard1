require 'oystercard'

describe Oystercard do
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
      limit = Oystercard::LIMIT
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

end
