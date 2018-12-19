# frozen_string_literal: true

require 'rails_helper'
require 'geo/trackpoint'
require 'geo/data/exceptions/parse_error'
require 'support/points_helper'

describe Tracks::RetrievePoints do
  context '.build' do
    subject { described_class.new.call(params) }

    context 'with valid attributes' do
      let(:file) { double('FileDouble') }
      let(:trackpoints) do
        PointsHelper.point_attributes.map do |trackpoint_attrs|
          Geo::Trackpoint.new(trackpoint_attrs)
        end
      end
      let(:parser_double) { double('Geo::Data::ParserDouble', call: trackpoints) }

      before do
        expect(Geo::Data::Parser).to receive(:new)
          .with(file).and_return(parser_double)
      end

      let(:params) do
        {
          track_attachment: file
        }
      end

      it 'succeeds' do
        expect(subject).to be_success
      end

      it "builds points properly" do
        expect(subject.success).to match(
          track_attachment: file,
          points_attributes: trackpoints.map(&:attributes)
        )
      end
    end

    context 'with invalid attributes' do
      let(:params) { {} }
      before do
        allow_any_instance_of(Geo::Data::Parser).to receive(:call)
          .and_raise(Geo::Data::Exceptions::ParseError)
      end

      it 'fails' do
        expect(subject).to be_failure
      end

      it "fails with proper message" do
        expect(subject.failure).to eq(track_attachment: Geo::Data::Exceptions::ParseError::MESSAGE)
      end
    end
  end
end
