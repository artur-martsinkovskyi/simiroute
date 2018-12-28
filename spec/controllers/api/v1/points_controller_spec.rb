require 'rails_helper'

describe Api::V1::PointsController do
  context "#index" do
    let(:track) { create(:track) }
    subject { get :index, params: { track_id: track.id } }

    it "returns success" do
      expect(subject).to be_successful
    end

    it "renders response" do
        expect(PointBlueprint).to receive(:render)
          .with(track.points, instance_of(Hash))
        subject
    end
  end

  context "#for_map" do
    let(:track) { create(:track) }
    subject { get :for_map, params: { track_id: track.id } }

    it "returns success" do
      expect(subject).to be_successful
    end

    it "renders response" do
        expect(PointBlueprint).to receive(:render)
          .with(track.points, instance_of(Hash))
        subject
    end
  end
end
