# frozen_string_literal: true

require 'rails_helper'
require 'geo/trackpoint'
require 'geo/data/exceptions/parse_error'

describe Tracks::RetrievePoints do
  describe '.build' do
    subject(:operation) { described_class.new.call(params) }

    context 'with valid attributes' do
      before do
        allow(Geo::Data::Parser).to receive(:new)
          .with(file).and_return(
            double(
              call: trackpoints
            )
          )
        allow(Geo::Displacement::PointMappingGenerator).to receive(:new)
          .and_return(double(call: sequence))
      end

      let(:file) { double('FileDouble') }
      let(:sequence) { 'sequence' }
      let(:trackpoints) do
        PointsHelper.trackpoint_attributes.map do |trackpoint_attrs|
          Geo::Trackpoint.new(trackpoint_attrs)
        end
      end

      let(:params) do
        {
          track_attachment: file
        }
      end

      let(:points_attributes) do
        trackpoints.map do |trackpoint|
          {
            **trackpoint.attributes,
            displacement_sequence: sequence
          }
        end
      end

      it 'call point mapping generator on every point' do
        operation.value!
        expect(Geo::Displacement::PointMappingGenerator).to have_received(:new)
          .exactly(trackpoints.size).times
      end

      it 'succeeds' do
        expect(operation).to be_success
      end

      it 'builds points properly' do
        expect(operation.success).to match(
          track_attributes: params,
          points_attributes: points_attributes
        )
      end
    end

    context 'with invalid attributes' do
      let(:params) { {} }
      let(:parser) { double }

      before do
        allow(Geo::Data::Parser).to receive(:new).and_return(parser)
        allow(parser).to receive(:call)
          .and_raise(Geo::Data::Exceptions::ParseError)
      end

      it 'fails' do
        expect(operation).to be_failure
      end

      it 'fails with proper message' do
        expect(operation.failure)
          .to eq(track_attachment: Geo::Data::Exceptions::ParseError::MESSAGE)
      end
    end
  end
end
