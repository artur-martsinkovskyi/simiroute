# frozen_string_literal: true

module Geo
  module Displacement
    class Sequence
      LEFT_TOP     = 1
      RIGHT_TOP    = 2
      LEFT_BOTTOM  = 3
      RIGHT_BOTTOM = 4

      TILE_SCHEMA = {
        right_bottom: {
          latitude: 1,
          longitude: 0,
          symbol: RIGHT_BOTTOM
        },
        left_bottom: {
          latitude: 1,
          longitude: 1,
          symbol: LEFT_BOTTOM
        },
        right_top: {
          latitude: 0,
          longitude: 0,
          symbol: RIGHT_TOP
        },
        left_top: {
          latitude: 0,
          longitude: 1,
          symbol: LEFT_TOP
        }

      }.freeze

      LATITUDE_LIMITS  = [-90.0,  +90.0].freeze
      LONGITUDE_LIMITS = [-180.0, +180.0].freeze

      private_class_method :new

      def initialize(
        lat,
        lng,
        latitude_limits,
        longitude_limits
      )
        @lat = lat
        @lng = lng
        @latitude_limits  = latitude_limits.dup
        @longitude_limits = longitude_limits.dup
      end

      def self.call(
        lat:,
        lng:,
        latitude_limits: LATITUDE_LIMITS,
        longitude_limits: LONGITUDE_LIMITS
      )
        new(lat, lng, latitude_limits, longitude_limits).send(
          :enumerator
        )
      end

      private

      attr_reader :lat, :lng, :longitude_limits, :latitude_limits

      def latitude_midline
        latitude_limits.sum / 2
      end

      def longitude_midline
        longitude_limits.sum / 2
      end

      def move(tile)
        tile_schema = TILE_SCHEMA[tile]
        latitude_limits[tile_schema[:latitude]] = latitude_midline
        longitude_limits[tile_schema[:longitude]] = longitude_midline
        tile_schema[:symbol]
      end

      # rubocop: disable Metrics/MethodLength
      def enumerator
        Enumerator.new do |yielder|
          loop do
            direction = if lat >= latitude_midline
                          if lng >= longitude_midline
                            :right_bottom
                          else
                            :left_bottom
                          end
                        elsif lng >= longitude_midline
                          :right_top
                        else
                          :left_top
                        end
            yielder.yield move(direction)
          end
        end
      end
      # rubocop: enable Metrics/MethodLength
    end
  end
end
