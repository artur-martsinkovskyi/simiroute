# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::TracksController do
  describe '#show' do
    subject(:show_request) { get :show, params: params }

    before do
      allow(TrackBlueprint).to receive(:render).and_return('{}')
    end

    let(:track) { create(:track) }
    let(:params) do
      {
        id: track.id
      }
    end

    it 'returns success' do
      expect(show_request).to be_successful
    end

    it 'calls blueprint' do
      show_request
      expect(TrackBlueprint).to have_received(:render)
        .with(track, instance_of(Hash))
    end
  end

  describe '#index' do
    subject(:index_request) { get :index }

    before do
      allow(TrackBlueprint).to receive(:render).and_return('{}')
      create(:track)
    end

    it 'returns success' do
      expect(index_request).to be_successful
    end

    it 'renders response' do
      index_request
      expect(TrackBlueprint).to have_received(:render)
        .with(Track.all, instance_of(Hash))
    end
  end

  describe '#compare' do
    subject(:compare_request) do
      get :compare, params: {
        track1: track1,
        track2: track2
      }
    end

    let(:track1) { create(:track) }
    let(:track2) { create(:track) }
    let(:points) { [] }
    let(:similarity) { [0.0, 0.0] }

    before do
      allow(Tracks::Compare).to receive(:new)
        .and_return(
          double(
            call: {
              points: points,
              similarity: similarity
            }
          )
        )
    end

    it 'calls Tracks::Compare' do
      compare_request
      expect(Tracks::Compare).to have_received(:new).with(track1, track2)
    end

    it 'is successful' do
      expect(compare_request).to be_successful
    end

    it 'returns proper schema' do
      expect(JSON.parse(compare_request.body)).to match(
        'points' => [],
        'similarity' => similarity
      )
    end
  end
end
