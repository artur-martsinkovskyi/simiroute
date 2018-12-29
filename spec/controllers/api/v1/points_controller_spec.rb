# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::PointsController do
  describe '#index' do
    subject(:index_request) { get :index, params: { track_id: track.id } }

    let(:track) { create(:track) }

    before do
      allow(PointBlueprint).to receive(:render).and_return('{}')
    end

    it 'returns success' do
      expect(index_request).to be_successful
    end

    it 'renders response' do
      index_request
      expect(PointBlueprint).to have_received(:render)
        .with(track.points, instance_of(Hash))
    end
  end
end
