require "journey"

describe Journey do
  let (:station_A) { double :station_A, zone: 1}
  let (:station_B) { double :station_A, zone: 1}
  let (:penalty) {Journey::PENALTY}
  let (:journey) { Journey.new }

  it 'records entry station when starting a new journey' do
    journey.start(station_A)
    expect(journey.completed_journey).to include(entry: station_A)
  end

  describe '#end' do
    it 'records exit station' do
      journey.end(station_B)
      expect(journey.completed_journey).to include(exit: station_B)
    end
  end

  describe '#fare' do
    it 'applies penalty for started but not finished journeys' do
      journey.start(station_A)
      expect(journey.fare).to eq(penalty)
    end

    it 'applies penalty for finished but not started journeys' do
      journey.end(station_B)
      expect(journey.fare).to eq(penalty)
    end

    it 'calculates fare' do
      journey.start(station_A)
      journey.end(station_B)
      expect(journey.fare).to eq(1)
    end
  end

  describe '#complete?' do
    it 'knows if journey is incomplete' do
      journey.start(station_A)
      expect(journey.complete?).to be false
    end

    it 'knows if journey is complete' do
      journey.start(station_A)
      journey.end(station_B)
      expect(journey.complete?).to be true
    end
  end

  describe '#completed_journey' do
    it 'returns hash of entry & exit stations' do
      journey.start(station_A)
      journey.end(station_B)
      expect(journey.completed_journey).to eq({entry: station_A, exit: station_B})
    end
  end

end
