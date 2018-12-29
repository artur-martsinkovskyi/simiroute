# frozen_string_literal: true

require 'rails_helper'

describe TrackBlueprint do
  subject(:render_result) { described_class.render_as_hash(track, view: view) }

  let(:view) { :default }
  let(:track) { build_stubbed(:track) }

  it 'renders id' do
    expect(render_result[:id]).to eq(track.id)
  end

  it 'renders uuid' do
    expect(render_result[:uuid]).to eq(track.uuid)
  end

  context 'when rendering minimal view' do
    let(:view) { :minimal }

    it 'renders points' do
      expect(render_result[:points]).to eq(
        PointBlueprint.render_as_hash(
          track.points
        )
      )
    end
  end

  context 'when rendering full view' do
    let(:view) { :full }

    it 'renders track_attachment' do
      expect(render_result[:track_attachment]).to eq(
        track.track_attachment
      )
    end

    it 'renders points' do
      expect(render_result[:points]).to eq(
        PointBlueprint.render_as_hash(track.points, view: view)
      )
    end
  end
end
