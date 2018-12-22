# frozen_string_literal: true

require 'geo/trackpoint'
require 'support/points_helper'

shared_examples 'parses trackpoints to common format' do
  let(:expected_result) do
    PointsHelper.point_attributes.map { |trackpoint_attributes| Geo::Trackpoint.new(trackpoint_attributes) }
  end
  subject { described_class.new(content) }

  it 'parses xml to an array of trackpoints' do
    expect(subject.call).to be_an(Array)
    expect(subject.call).to(be_all { |el| el.is_a?(Geo::Trackpoint) })
  end

  it 'parses xml properly' do
    expect(subject.call).to match_array(expected_result)
  end
end
