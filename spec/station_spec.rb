require 'station'

describe Station do
  let (:station) { Station.new("Waterloo", "1") }

  describe "#name" do
    it 'stores name' do
      expect(station.name).to eq "Waterloo"
    end
  end

  describe "#zone" do
    it 'stores zone' do
      expect(station.zone).to eq "1"
    end
  end
end
