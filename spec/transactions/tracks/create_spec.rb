require 'rails_helper'
require 'geo/data/exceptions/parse_error'

describe Tracks::Create do
  subject { described_class.new }

  context "with invalid data" do
    context "with invalid parameters" do
      let(:params) { { wrong_parameter: nil } }

      it "fails" do
        expect(subject.call(params)).to be_failure
      end

      it "fails on a proper field" do
        expect(subject.call(params).failure).to eq(track_attachment: ["is missing"])
      end
    end

    context "that causes build exception" do
      let(:params) { { track_attachment: double("FileDouble") } }
      before do
        allow(TrackBuilder).to receive(:create).with(params)
          .and_raise(Geo::Data::Exceptions::ParseError)
      end

      it "fails" do
        expect(subject.call(params)).to be_failure
      end

      it "fails with proper message" do
        expect(subject.call(params).failure).to eq(
          track_attachment: Geo::Data::Exceptions::ParseError::MESSAGE
        )
      end
    end
  end

  context "with valid_data" do
    let(:params) { { track_attachment: double("FileDouble") } }
    let(:track) { double("Track") }
    before do
      allow(TrackBuilder).to receive(:create).with(params)
        .and_return(track)
    end

    it "succeeds" do
      expect(subject.call(params)).to be_success
    end

    it "returns result of track build as success" do
      expect(subject.call(params).success).to be(track)
    end
  end
end
