# frozen_string_literal: true

require 'ox'
require_relative '../../trackpoint'
require_relative 'base'
require_relative '../constants'

module Geo
  module Data
    module Strategies
      class Gpx < Base
        def self.extension
          Constants::GPX
        end

        private

        def retrieve_data
          trackpoint_attributes.map do |trackpoint, element, time|
            Geo::Trackpoint.new(
              lat: trackpoint[:lat],
              lng: trackpoint[:lon],
              tracked_at: Time.parse(time[:time]).utc,
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
