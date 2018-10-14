require 'journeylog'

describe JourneyLog do

    let(:journey){ double :journey, start: true, end: true, completed_journey: {entry: entry_station, exit: exit_station} }
    let (:entry_station) { double :entry_station }
    let (:exit_station) { double :exit_station }
    let(:journey_class){double :journey_class, new: journey}
    subject {described_class.new(journey_class: journey_class)}
    before { allow(subject).to receive(:current_journey).and_return(journey) }

    describe '#start' do
      it 'starts a journey' do
        expect(journey).to receive(:start).with(entry_station)
        subject.start(entry_station)
      end
    end

    describe '#end' do
      it 'ends a journey' do
        expect(journey).to receive(:end).with(exit_station)
        subject.end(exit_station)
      end
    end


      it 'records a journey' do
        allow(journey_class).to receive(:new).and_return journey
        subject.start(entry_station)
        subject.end(entry_station)
        expect(subject.journeys).to include journey
      end

#
#   it 'stores data from current journey in journeys' do
#     journey_log.finish(exit_station)
#     expect(journey_log.journeys).to include({test: "test"})
#   end
#
# end

#
# end
  end
