# frozen_string_literal: true

require 'rails_helper'
require 'geo/trackpoint'
require 'support/points_helper'

describe TrackBuilder do
  context '.build' do
    subject { described_class.build(params) }

    context 'with valid attributes' do
      let(:file_double) { double('FileDouble') }
      let(:trackpoints) do
        JSON.parse(File.read('spec/fixtures/files/sample.json'))['points'].map do |trackpoint_attrs|
          Geo::Trackpoint.new(trackpoint_attrs.tap { |attrs| attrs['time'] = Time.parse(attrs['time']) }.symbolize_keys)
        end
      end
      let(:parser_double) { double('Geo::Data::ParserDouble', call: trackpoints) }

      before do
        expect(Geo::Data::Parser).to receive(:new)
          .with(file_double).and_return(parser_double)
      end

      let(:params) do
        {
          track_attachment: file_double
        }
      end

      it 'builds a valid track' do
        expect(subject).to be_valid
      end

      it 'builds points for the track' do
        expect(subject.points.size).to eq(trackpoints.size)
      end
    end
    context 'with invalid attributes' do
      let(:params) { {} }

      it 'raises KeyError' do
        expect { subject }.to raise_error(KeyError)
      end
    end
  end

  context '.create' do
    subject { described_class.create(params) }
    let(:file_double) { double('FileDouble') }
    let(:trackpoints) do
      PointsHelper.point_attributes.map do |trackpoint_attrs|
        Geo::Trackpoint.new(trackpoint_attrs)
      end
    end
    let(:parser_double) { double('Geo::Data::ParserDouble', call: trackpoints) }

    before do
      expect(Geo::Data::Parser).to receive(:new)
        .with(file_double).and_return(parser_double)
    end

    let(:params) do
      {
        track_attachment: file_double
      }
    end

    it 'builds a valid track' do
      expect { subject }.to change { Track.count }.by(1)
    end

    it 'builds points for the track' do
      expect { subject }.to change { Point.count }.by(trackpoints.size)
    end
  end
end
