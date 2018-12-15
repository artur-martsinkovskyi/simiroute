# frozen_string_literal: true

require 'ox'
require_relative '../../trackpoint'

module Geo
  module Data
    module Strategies
      class Gpx
        attr_reader :content

        def initialize(content)
          @content = content
        end

        def call
          trackpoint_data.map do |trackpoint, element, time|
            Geo::Trackpoint.new(
              lat: trackpoint[:lat],
              lon: trackpoint[:lon],
              time: Time.parse(time[:time]),
              altitude: element[:ele]
            )
          end
        end

        private

        def trackpoint_data
          xml_hash[:gpx][1][:trk][:trkseg][:trkpt]
        end

        def xml_hash
          Ox.load(content, mode: :hash)
        end
      end
    end
  end
end
