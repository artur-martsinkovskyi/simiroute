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

    context "when passed no view http parameter" do
      it "responds with minimal" do
        expect(TrackBlueprint).to receive(:render)
          .with(track, view: :minimal)
        subject
      end
    end

    context "when passed no view http parameter" do
      let(:params) do
        {
          id: track.id,
          view: :full
        }
      end

      it "responds with full" do
        expect(TrackBlueprint).to receive(:render)
          .with(track, view: :full)
        subject
      end
    end
  end

  context "#index" do
    before do
      create(:track)
    end
    subject { get :index }

    it "returns success" do
      expect(subject).to be_successful
    end

    it "renders response" do
        expect(TrackBlueprint).to receive(:render)
          .with(Track.all, view: :minimal)
        subject
    end
  end
end
