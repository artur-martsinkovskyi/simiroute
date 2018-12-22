# frozen_string_literal: true

require 'geo/data/strategies/plt'
require_relative 'parses_trackpoints_to_common_format_examples'

describe Geo::Data::Strategies::Plt do
  let(:content) { File.read('spec/fixtures/files/sample.plt') }
  before do
    allow(subject).to receive(:foot_to_meter) { |foot| foot }
  end
  include_examples 'parses trackpoints to common format'
end
