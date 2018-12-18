require "rails_helper"

describe Tracks::Create do
  context "with invalid data" do
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
