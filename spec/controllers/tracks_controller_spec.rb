# frozen_string_literal: true

require 'rails_helper'

describe TracksController do
  render_views
  let(:distance) { 10 }

  before do
    allow_any_instance_of(Lambdas::DistanceLambda).to receive(:call).with(payload: instance_of(Array)).and_return(distance)
  end

  context 'when not logged in' do
    describe '#index' do
      let!(:tracks) { create_list(:track, 3) }

      before do
        get :index
      end

      it 'renders page' do
        expect(response).to be_successful
      end

      it 'renders tracks' do
        tracks.each do |track|
          expect(response.body).to include(track.uuid)
        end
      end
    end

    describe '#show' do
      let!(:track) { create(:track) }

      before do
        get :show, params: { id: track.id }
      end

      it 'renders page' do
        expect(response).to be_successful
      end

      it 'renders track' do
        expect(response.body).to include(track.uuid)
      end
    end

    describe '#new' do
      before do
        get :new
      end

      it 'redirects to root' do
        expect(response).to have_http_status(:found)
      end
    end

    describe '#create' do
      subject(:create_request) do
        get :create, params: params
      end

      let(:params) do
        {
          track: attributes_for(:track)
        }
      end

      it 'redirects to root' do
        expect(create_request).to have_http_status(:found)
      end

      it 'does not create a track' do
        expect { create_request }.not_to change(Track, :count)
      end
    end

    describe '#compare' do
      before do
        get :compare
      end

      it 'redirects to root' do
        expect(response).to have_http_status(:found)
      end
    end
  end

  context 'when user logged in' do
    before { sign_in_as user }

    let(:user) { create(:user) }

    describe '#compare' do
      before do
        get :compare
      end

      it 'renders page' do
        expect(response).to be_successful
      end
    end

    describe '#new' do
      before do
        get :new
      end

      it 'renders page' do
        expect(response).to be_successful
      end
    end

    describe '#create' do
      subject(:create_request) { post :create, params: params }

      context 'when with valid attributes' do
        let(:params) do
          {
            track: attributes_for(:track)
          }
        end

        it 'is successful' do
          expect(create_request).to have_http_status(:found)
        end

        it 'creates a track' do
          expect { create_request }.to change { user.tracks.count }.by(1)
        end

        it 'creates points' do
          expect { create_request }.to change(Point, :count).by(3)
        end
      end

      context 'when with invalid attributes' do
        let(:params) do
          {
            track: {}
          }
        end

        it 'renders new' do
          create_request
          expect(response.body).to include('Create Track')
        end

        it 'does not create a track' do
          expect { create_request }.not_to change(Track, :count)
        end

        it 'does not create points' do
          expect { create_request }.not_to change(Point, :count)
        end
      end
    end
  end
end
