# frozen_string_literal: true

require 'rails_helper'

describe Tracks::Persist do
  describe '#call' do
    subject(:operation) { described_class.new.call(params) }

    let(:params) do
      {
        **attributes_for(:track),
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
end
