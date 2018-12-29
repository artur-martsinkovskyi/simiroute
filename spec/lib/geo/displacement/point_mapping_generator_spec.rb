# frozen_string_literal: true

require 'geo/displacement/point_mapping_generator'
require 'geo/displacement/sequence'

describe Geo::Displacement::PointMappingGenerator do
  describe '#call' do
    subject(:call_result) { described_class.new(point).call }

    let(:lat)   { double }
    let(:lng)   { double }
    let(:point) { double(lat: lat, lng: lng) }

    [
      [[1, 2, 3, 4], 'pqst'],
      [[4, 3, 2, 1], 'tsqp'],
      [[3, 4, 1, 2], 'stpq'],
      [[1, 1, 1, 1, 1], 'ppppp']
    ].each do |tile_displacement, result|
      context "for tile displacement #{tile_displacement}" do
        before do
          allow(Geo::Displacement::Sequence)
            .to receive(:call).and_return(tile_displacement)
        end

        it 'calls sequence' do
          call_result
          expect(Geo::Displacement::Sequence)
            .to have_received(:call).with(lat: lat, lng: lng)
        end

        it 'returns properly mapped result of Sequence' do
          expect(call_result).to eq(result)
        end
      end
    end
  end
end
