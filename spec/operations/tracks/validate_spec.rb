require "rails_helper"
require 'geo/data/exceptions/parse_error'

describe Tracks::Validate do
  context "with invalid parameters" do
    let(:params) { { wrong_parameter: nil } }

    it "fails" do
      expect(subject.call(params)).to be_failure
    end

    it "fails on a proper field" do
      expect(subject.call(params).failure).to eq(track_attachment: ["is missing"])
    end
  end

  context "with valid parameters" do
    let(:params) { { track_attachment: double("FileDouble") } }

    it "succeeds" do
      expect(subject.call(params)).to be_success
    end

    it "returns input hash" do
      expect(subject.call(params).success).to be(params)
    end
  end
end
