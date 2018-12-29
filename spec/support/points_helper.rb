# frozen_string_literal: true

module PointsHelper
  module_function

  # rubocop: disable Metrics/MethodLength
  def trackpoint_attributes
    [{
      lat: '41',
      lng: '24',
      altitude: '1371',
      tracked_at: Time.zone.parse('2008-08-15T07:03:56Z')
    },
     {
       lat: '42',
       lng: '25',
       altitude: '1372',
       tracked_at: Time.zone.parse('2008-08-15T07:03:58Z')
     },
     {
       lat: '43',
       lng: '26',
       altitude: '1373',
       tracked_at: Time.zone.parse('2008-08-15T07:03:59Z')
     }]
  end
  # rubocop: enable Metrics/MethodLength

  # rubocop: disable Metrics/MethodLength
  def point_attributes
    [{
      lat: '41',
      lng: '24',
      altitude: '1371',
      tracked_at: '2008-08-15T07:03:56Z',
      displacement_sequence: 'tsstssstssstssstssst'
    },
     {
       lat: '42',
       lng: '25',
       altitude: '1372',
       tracked_at: '2008-08-15T07:03:58Z',
       displacement_sequence: 'tsstssstttssstttssst'
     },
     {
       lat: '43',
       lng: '26',
       altitude: '1373',
       tracked_at: '2008-08-15T07:03:59Z',
       displacement_sequence: 'tsstsstsstttttstssts'
     }]
  end
  # rubocop: enable Metrics/MethodLength
end
