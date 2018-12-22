require "rails_helper"

describe Tracks::Persist do
  let(:params) do
    {
      **attributes_for(:track),
      points_attributes: PointsHelper.point_attributes
    }
  end

  it "succeeds" do
    expect(subject.call(params)).to be_success
  end

  it "returns result of track build as success" do
    expect{ subject.call(params).success }.to change { Track.count }.by(1)
  end
end
