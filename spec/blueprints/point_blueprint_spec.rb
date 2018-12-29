# frozen_string_literal: true

require 'rails_helper'

describe PointBlueprint do
  subject(:render_result) { described_class.render_as_hash(point, view: view) }

  let(:view) { :default }
  let(:point) { build_stubbed(:point) }

  it 'renders fields' do
    expect(render_result[:id]).to eq(point.id)
  end

  it 'renders lat' do
    expect(render_result[:lat]).to eq(point.lat)
  end

  it 'renders lng' do
    expect(render_result[:lng]).to eq(point.lng)
  end

  context 'when full view' do
    let(:view) { :full }

    it 'renders altitude' do
      expect(render_result[:altitude]).to eq(point.altitude)
    end

    it 'renders tracked_at' do
      expect(render_result[:tracked_at]).to eq(point.tracked_at)
    end
  end
end
