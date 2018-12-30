# frozen_string_literal: true

require 'rails_helper'

describe Tracks::Persist do
  describe '#call' do
    subject(:operation) { described_class.new.call(params) }

    let(:user) { create(:user) }

    context 'when track is able to be saved' do
      let(:params) do
        {
          track_attributes: {
            user_id: user.id,
            **attributes_for(:track)
          },
          points_attributes: PointsHelper.point_attributes
        }
      end

      it 'succeeds' do
        expect(operation).to be_success
      end

      it 'creates track' do
        expect { operation.value! }.to change(Track, :count).by(1)
      end

      it 'creates points' do
        expect { operation.value! }
          .to change(Point, :count).by(params[:points_attributes].size)
      end

      it 'returns track with points' do
        expect(operation.success).to be_a(Track)
      end

      it 'returned track has points' do
        expect(operation.success.points).to be_any
      end
    end

    context 'when track is unable to be saved' do
      let(:params) do
        {
          track_attributes: {},
          points_attributes: PointsHelper.point_attributes
        }
      end

      it 'is a failure' do
        expect(operation).to be_failure
      end

      it 'does not save the track' do
        expect { operation }.not_to change(Track, :count)
      end

      it 'does not save the points' do
        expect { operation }.not_to change(Point, :count)
      end

      it 'returns errors from track' do
        expect(operation.failure).to eq(
          track_attachment: ["can't be blank"],
          user: ['must exist']
        )
      end
    end
  end
end
