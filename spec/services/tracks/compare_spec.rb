# frozen_string_literal: true

require 'rails_helper'

describe Tracks::Compare do
  describe '#call' do
    subject(:comparison_result) { described_class.new(track1, track2).call }

    context 'when tracks are identical' do
      let(:track1) { create(:track) }
      let(:track2) { create(:track) }

      it 'returns  first point tracks' do
        expect(comparison_result[:points]).to eq(track1.points)
      end

      it 'returns 100% similarity in both ways' do
        expect(comparison_result[:similarity]).to eq([100.0, 100.0])
      end
    end

    context 'when tracks are not identical' do
      context 'when one of three points diverges' do
        let(:track1) { create(:track) }
        let(:track2) do
          track = build(
            :track,
            points_attributes: [
              *PointsHelper.point_attributes.take(2),
              attributes_for(:point)
            ]
          )
          track.save
          track
        end

        it 'returns matching first point tracks' do
          expect(comparison_result[:points]).to eq(track1.points.take(2))
        end

        it 'returns 66% similarity in both ways' do
          expect(comparison_result[:similarity]).to eq([66.67, 66.67])
        end
      end

      context 'when second track is contained in the first' do
        let(:track1) { create(:track) }
        let(:track2) do
          track = build(
            :track,
            points_attributes: [
              *PointsHelper.point_attributes.take(2)
            ]
          )
          track.save
          track
        end

        it 'returns matching first point tracks' do
          expect(comparison_result[:points]).to eq(track1.points.take(2))
        end

        it 'returns 66% similarity from first to second' do
          expect(comparison_result[:similarity][0]).to eq(66.67)
        end

        it 'returns 100% similarity from second to first' do
          expect(comparison_result[:similarity][1]).to eq(100.0)
        end
      end

      context 'when tracks are fully different' do
        let(:track1) { create(:track) }
        let(:track2) do
          track = build(
            :track,
            points_attributes: attributes_for_list(:point, 3)
          )
          track.save
          track
        end

        it 'returns empty collection' do
          expect(comparison_result[:points]).to be_empty
        end

        it 'returns 0% similarity in both ways' do
          expect(comparison_result[:similarity]).to eq([0.0, 0.0])
        end
      end
    end
  end
end
