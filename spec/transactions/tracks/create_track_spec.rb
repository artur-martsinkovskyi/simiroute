require 'rails_helper'
require 'geo/data/exceptions/parse_error'
require 'geo/data/parser'
require 'geo/trackpoint'

describe Tracks::CreateTrack do
  subject { described_class.new }

  context "with invalid data" do
    context "with invalid parameters" do
      let(:params) { { wrong_parameter: nil } }

      it "fails" do
        expect(subject.call(params)).to be_failure
      end
    end

    context "that causes build exception" do
      let(:file)    { double("FileDouble") }
      let(:params) { { track_attachment: file } }
      let(:parser) { double("ParserDouble") }

      before do
        allow(Geo::Data::Parser).to receive(:new).with(file).and_return(parser)
        allow(parser).to receive(:call)
          .and_raise(Geo::Data::Exceptions::ParseError)
      end

      it "fails" do
        expect(subject.call(params)).to be_failure
      end
    end
  end

  context "with valid_data" do
    let(:file) { double("FileDouble")  }
    let(:params) { { track_attachment: file } }
    let(:parser) { double("ParserDouble") }
    let(:trackpoints) do
      PointsHelper.point_attributes.map { |attrs| Geo::Trackpoint.new(attrs) }
    end

    before do
      allow(Geo::Data::Parser).to receive(:new).with(file).and_return(parser)
      allow(parser).to receive(:call).and_return(trackpoints)
    end

    it "succeeds" do
      expect(subject.call(params)).to be_success
    end

    it "creates track" do
      expect { subject.call(params) }.to change { Track.count }.by(1)
    end
  end
end
