require "geo/displacement/sequence"

describe Geo::Displacement::Sequence do
  context "#call" do
    subject { described_class.call(params) }

    let(:lat) { double }
    let(:lng) { double }
    let(:longitude_limits) { double }
    let(:latitude_limits) { double }
    let(:params) do
      {
        lat: lat,
        lng: lng,
        latitude_limits: latitude_limits,
        longitude_limits: longitude_limits
      }
    end

    it "duplicates limits" do
      expect(latitude_limits).to receive(:dup)
      expect(longitude_limits).to receive(:dup)
      subject
    end


    it "returns an enumerator" do
      expect(subject).to be_an(Enumerator)
    end

    context "without limits passed" do
      let(:params) do
        {
          lat: lat,
          lng: lng
        }
      end

      it "uses default limits" do
        expect(described_class).to receive(:new).with(
          lat,
          lng,
          described_class::LATITUDE_LIMITS,
          described_class::LONGITUDE_LIMITS
        ).and_call_original
        subject
      end
    end


    [
      [{ lat: -90, lng: -180 }, [1, 1, 1, 1]],
      [{ lat: -90, lng:  180 }, [2, 2, 2, 2]],
      [{ lat:  90, lng: -180 }, [3, 3, 3, 3]],
      [{ lat:  90, lng:  180 }, [4, 4, 4, 4]],
      [{ lat:  0,  lng:  0 },   [4, 3, 3, 3]],
      [{ lat:  45, lng:  45 },  [4, 3, 4, 3]],
      [{ lat:  38, lng: -38 },  [3, 4, 4, 3]],
    ].each do |attrs, result|
      context "with #{attrs}" do
        let(:params) do
          attrs
        end

        it "returns correct sequence" do
          expect(subject.take(4)).to eq(result)
        end
      end
    end
  end
end
