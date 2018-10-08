require 'oystercard'

describe Oystercard do
  describe '#balance' do
    it 'returns initial balance 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'it updates balance with amount' do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end
  end

end
