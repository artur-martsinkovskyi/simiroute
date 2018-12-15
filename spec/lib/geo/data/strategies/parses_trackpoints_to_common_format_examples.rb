# frozen_string_literal: true

require 'geo/trackpoint'

shared_examples 'parses trackpoints to common format' do
  let(:expected_result) do
    [
      {
        lat: '41',
        lon: '24',
        altitude: '1371',
        time: Time.parse('2008-08-15T07:03:56Z')
      },
      {
        lat: '42',
        lon: '25',
        altitude: '1372',
        time: Time.parse('2008-08-15T07:03:58Z')
      },
      {
        lat: '43',
        lon: '26',
        altitude: '1373',
        time: Time.parse('2008-08-15T07:03:59Z')
      }
    ].map { |trackpoint_attributes| Geo::Trackpoint.new(trackpoint_attributes) }
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
