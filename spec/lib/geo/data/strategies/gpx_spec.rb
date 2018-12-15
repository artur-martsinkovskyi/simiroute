# frozen_string_literal: true

require 'geo/data/strategies/gpx'
require_relative 'parses_trackpoints_to_common_format_examples'

describe Geo::Data::Strategies::Gpx do
  let(:content) { File.read('spec/fixtures/files/sample.gpx') }
  include_examples 'parses trackpoints to common format'
end
