# frozen_string_literal: true

require 'rails_helper'
require 'geo/data/exceptions/parse_error'

describe Tracks::Validate do
  describe '#call' do
    subject(:call_result) { described_class.new.call(params) }

    context 'with invalid parameters' do
      let(:params) { { wrong_parameter: nil, user_id: nil } }

      it 'fails' do
        expect(call_result).to be_failure
      end

      it 'fails on a proper field' do
        expect(call_result.failure).to eq(
          track_attachment: ['is missing'],
          user_id: ['must be filled']
        )
      end
    end

    context 'with valid parameters' do
      let(:user) { create(:user) }
      let(:params) do
        {
          track_attachment: double('FileDouble'),
          user_id: user.id
        }
      end

      it 'succeeds' do
        expect(call_result).to be_success
      end

      it 'returns input hash' do
        expect(call_result.success).to be(params)
      end
    end
  end
end
