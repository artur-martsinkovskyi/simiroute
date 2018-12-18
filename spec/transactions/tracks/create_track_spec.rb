require 'rails_helper'

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
      let(:params) { { track_attachment: double("FileDouble") } }
      before do
        allow(TrackBuilder).to receive(:create).with(params)
          .and_raise(Geo::Data::Exceptions::ParseError)
      end

      it "fails" do
        expect(subject.call(params)).to be_failure
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
  end
end
