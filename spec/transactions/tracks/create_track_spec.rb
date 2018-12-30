# frozen_string_literal: true

require 'rails_helper'
require 'geo/data/exceptions/parse_error'
require 'geo/data/parser'
require 'geo/trackpoint'

describe Tracks::CreateTrack do
  subject(:transaction) { described_class.new.call(params) }

  context 'with invalid data' do
    context 'with invalid parameters' do
      let(:params) { { wrong_parameter: nil } }

      it 'fails' do
        expect(transaction).to be_failure
      end
    end

    context 'when it causes build exception' do
      let(:file) { double('FileDouble') }
      let(:params) { { track_attachment: file } }
      let(:parser) { double('ParserDouble') }

      before do
        allow(Geo::Data::Parser).to receive(:new).with(file).and_return(parser)
        allow(parser).to receive(:call)
          .and_raise(Geo::Data::Exceptions::ParseError)
      end

      it 'fails' do
        expect(transaction).to be_failure
      end
    end
  end

  context 'with valid_data' do
    let(:user) { create(:user) }
    let(:params) do
      {
        **attributes_for(:track),
        user_id: user.id
      }
    end
    let(:file) { params[:track_attachment] }
    let(:parser) { double('ParserDouble') }
    let(:trackpoints) do
      PointsHelper.trackpoint_attributes.map do |attrs|
        Geo::Trackpoint.new(attrs)
      end
    end

    before do
      allow(Geo::Data::Parser).to receive(:new).with(file).and_return(parser)
      allow(parser).to receive(:call).and_return(trackpoints)
    end

    it 'succeeds' do
      expect(transaction).to be_success
    end

    it 'creates track' do
      expect { transaction }.to change(Track, :count).by(1)
    end
  end
end
