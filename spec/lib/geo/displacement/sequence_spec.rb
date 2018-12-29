# frozen_string_literal: true

require 'geo/displacement/sequence'

describe Geo::Displacement::Sequence do
  describe '#call' do
    subject(:sequence) { described_class.call(params) }

    let(:lat) { double }
    let(:lng) { double }
    let(:latitude_limits) { instance_spy(Array, 'LatitudeLimits') }
    let(:longitude_limits) { instance_spy(Array, 'LongitudeLimits') }
    let(:params) do
      {
        lat: lat,
        lng: lng,
        latitude_limits: latitude_limits,
        longitude_limits: longitude_limits
      }
    end

    # By an unknown reason have_received post assert
    # strategy does not work here, so I suppressed rubocop
    # and used pre assert spying.
    # rubocop: disable RSpec/MessageSpies
    # rubocop: disable RSpec/MultipleExpectations
    it 'duplicates limits' do
      expect(longitude_limits).to receive(:dup)
      expect(latitude_limits).to receive(:dup)
      sequence
    end
    # rubocop: enable RSpec/MultipleExpectations
    # rubocop: enable RSpec/MessageSpies

    it 'returns an enumerator' do
      expect(sequence).to be_an(Enumerator)
    end

    context 'without limits passed' do
      let(:params) do
        {
          lat: lat,
          lng: lng
        }
      end

      before do
        allow(described_class).to receive(:new).and_call_original
      end

      it 'uses default limits' do
        sequence
        expect(described_class)
          .to have_received(:new).with(
            lat,
            lng,
            described_class::LATITUDE_LIMITS,
            described_class::LONGITUDE_LIMITS
          )
      end
    end

    [
      [{ lat: -90, lng: -180 }, [1, 1, 1, 1]],
      [{ lat: -90, lng:  180 }, [2, 2, 2, 2]],
      [{ lat:  90, lng: -180 }, [3, 3, 3, 3]],
      [{ lat:  90, lng:  180 }, [4, 4, 4, 4]],
      [{ lat:  0,  lng:  0 },   [4, 3, 3, 3]],
      [{ lat:  45, lng:  45 },  [4, 3, 4, 3]],
      [{ lat:  38, lng: -38 },  [3, 4, 4, 3]]
    ].each do |attrs, result|
      context "with #{attrs}" do
        let(:params) do
          attrs
        end

        it 'returns correct sequence' do
          expect(sequence.take(4)).to eq(result)
        end
      end
    end
  end
end
