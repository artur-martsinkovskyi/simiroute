# frozen_string_literal: true

require 'rails_helper'
require 'geo/trackpoint'
require 'geo/data/exceptions/parse_error'

describe Tracks::RetrievePoints do
  context '.build' do
    subject { described_class.new.call(params) }

    context 'with valid attributes' do
      let(:file) { double('FileDouble') }
      let(:sequence) { "sequence" }
      let(:trackpoints) do
        PointsHelper.point_attributes.map do |trackpoint_attrs|
          Geo::Trackpoint.new(trackpoint_attrs)
        end
      end

      before do
        expect(Geo::Data::Parser).to receive(:new)
          .with(file).and_return(
            double(
              call: trackpoints
            )
        )
      end

      before do
        expect(Geo::Displacement::PointMappingGenerator).to receive(:new)
          .exactly(trackpoints.size).times.and_return(double(call: sequence))
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

      it 'succeeds' do
        expect(subject).to be_success
      end

      it "builds points properly" do
        expect(subject.success).to match(
          track_attributes: params,
          points_attributes: points_attributes
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
