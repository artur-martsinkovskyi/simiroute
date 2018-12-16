# frozen_string_literal: true

require 'ox'
require_relative '../../trackpoint'
require_relative 'base'

module Geo
  module Data
    module Strategies
      class Gpx < Base
        private

        def retrieve_data
          trackpoint_attributes.map do |trackpoint, element, time|
            Geo::Trackpoint.new(
              lat: trackpoint[:lat],
              lon: trackpoint[:lon],
              time: Time.parse(time[:time]),
              altitude: element[:ele]
            )
          end
        end

        def trackpoint_attributes
          data_hash[:gpx][1][:trk][:trkseg][:trkpt]
        end

        def data_hash
          Ox.load(content, mode: :hash)
        end
      end
    end
  end
end
