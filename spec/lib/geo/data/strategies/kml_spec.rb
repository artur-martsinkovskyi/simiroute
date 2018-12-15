# frozen_string_literal: true

require 'geo/data/strategies/kml'
require_relative 'parses_trackpoints_to_common_format_examples'

describe Geo::Data::Strategies::Kml do
  let(:content) { File.read('spec/fixtures/files/sample.kml') }
  include_examples 'parses trackpoints to common format'
end
