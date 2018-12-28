require "rails_helper"

describe TracksController do
  render_views

  context "#index" do
    let!(:tracks) { create_list(:track, 3) }
    before do
      get :index
    end

    it "renders page" do
      expect(response).to be_successful
    end

    it "renders tracks" do
      tracks.each do |track|
        expect(response.body).to include(track.uuid)
      end
    end
  end

  context "#show" do
    let!(:track) { create(:track) }
    before do
      get :show, params: { id: track.id }
    end

    it "renders page" do
      expect(response).to be_successful
    end

    it "renders track" do
      expect(response.body).to include(track.uuid)
    end
  end

  context "#new" do
    before do
      get :new
    end

    it "renders page" do
      expect(response).to be_successful
    end
  end

  context "#create" do
    subject { post :create, params: params }

    context "with valid attributes" do
      let(:params) do
        {
          track: attributes_for(:track)
        }
      end

      it "is successful" do
        expect(subject).to have_http_status(302)
      end

      it "creates a track" do
        expect { subject }.to change { Track.count }.by(1)
      end

      it "creates points" do
        expect { subject }.to change { Point.count }.by(3)
      end
    end

    context "with invalid attributes" do
      let(:params) do
        {
          track: {}
        }
      end

      it "renders new" do
        expect(subject.body).to include("Create Track")
      end

      it "does not create a track" do
        expect { subject }.not_to change { Track.count }
      end

      it "does not create points" do
        expect { subject }.not_to change { Point.count }
      end
    end
  end
end
