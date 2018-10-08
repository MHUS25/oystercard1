require "journey"



describe Journey do
  let (:station_A) { double(:station_A) }
  let (:station_B) { double(:station_B) }
  let (:penalty) {Journey::PENALTY}
  let (:journey) { Journey.new("Waterloo") }



  describe '#end' do
    it 'records exit station' do
      journey.end(station_B)
      expect(journey.exit_station).to eq(station_B)
    end
  end

  describe '#fare' do
    it 'has penalty for incomplete journey' do
      expect(journey.fare).to eq(penalty)
    end
  end

end
