# frozen_string_literal: true

require 'geo/trackpoint'
require 'support/points_helper'

shared_examples 'parses trackpoints to common format' do
  subject(:strategy_result) { described_class.new(content).call }

  let(:expected_result) do
    PointsHelper.trackpoint_attributes.map do |trackpoint_attributes|
      Geo::Trackpoint.new(trackpoint_attributes)
    end
  end

  it 'parses xml to an array of trackpoints' do
    expect(strategy_result).to be_an(Array)
  end

  it 'pareses xml into trackpoints' do
    expect(strategy_result).to(be_all { |el| el.is_a?(Geo::Trackpoint) })
  end

  it 'parses xml properly' do
    expect(strategy_result).to match_array(expected_result)
  end
end
