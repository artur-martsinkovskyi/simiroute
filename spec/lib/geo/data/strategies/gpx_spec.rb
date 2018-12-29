# frozen_string_literal: true

require 'geo/data/strategies/gpx'
require 'geo/data/constants'
require_relative 'parses_trackpoints_to_common_format_examples'

describe Geo::Data::Strategies::Gpx do
  describe '#call' do
    let(:content) { File.read('spec/fixtures/files/sample.gpx') }

    include_examples 'parses trackpoints to common format'
  end

  describe '.extension' do
    it 'returns correct constant value' do
      expect(described_class.extension).to eq(Geo::Data::Constants::GPX)
    end
  end
end
