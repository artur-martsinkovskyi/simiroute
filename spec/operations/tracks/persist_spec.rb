require "rails_helper"

describe Tracks::Persist do
  let(:params) do
    {
      **attributes_for(:track),
      points_attributes: PointsHelper.point_attributes
    }
  end

  subject { described_class.new.call(params) }

  it "succeeds" do
    expect(subject).to be_success
  end

  it "creates track" do
    expect{ subject.value! }.to change { Track.count }.by(1)
  end

  it "creates points" do
    expect{ subject.value! }.to change { Point.count }.by(params[:points_attributes].size)
  end

  it "returns track with points" do
    expect(subject.success).to be_a(Track)
    expect(subject.success.points).to be_any
  end
end
