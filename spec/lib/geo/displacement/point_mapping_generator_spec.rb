require "geo/displacement/point_mapping_generator"
require "geo/displacement/sequence"


describe Geo::Displacement::PointMappingGenerator do
  let(:lat)   { double }
  let(:lng)   { double }
  let(:point) { double(lat: lat, lng: lng) }
  subject { described_class.new(point).call }

  [
    [[1, 2, 3, 4], "pqst"],
    [[4, 3, 2, 1], "tsqp"],
    [[3, 4, 1, 2], "stpq"],
    [[1, 1, 1, 1, 1], "ppppp"]
  ].each do |tile_displacement, result|
    context "for tile displacement #{tile_displacement}" do
      before do
        expect(Geo::Displacement::Sequence).to receive(:call).with(lat: lat, lng: lng)
          .and_return(tile_displacement)
      end

      it "returns properly mapped result of Sequence" do
        expect(subject).to eq(result)
      end
    end
  end
end
