require 'rails_helper'

describe Api::V1::TracksController do
  context "#show" do
    let(:track) { create(:track) }
    let(:params) do
      {
        id: track.id
      }
    end
    subject { get :show, params: params }

    it "returns success" do
      expect(subject).to be_successful
    end

      it "calls blueprint" do
        expect(TrackBlueprint).to receive(:render)
          .with(track, instance_of(Hash))
        subject
      end
  end

  context "#index" do
    before { create(:track) }
    subject { get :index }

    it "returns success" do
      expect(subject).to be_successful
    end

    it "renders response" do
        expect(TrackBlueprint).to receive(:render)
          .with(Track.all, instance_of(Hash))
        subject
    end
  end
end
