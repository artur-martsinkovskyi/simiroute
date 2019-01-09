# frozen_string_literal: true

require_relative 'sequence'

module Geo
  module Displacement
    class PointMappingGenerator
      DEPTH = 25
      TILE_MAPPING = {
        1 => 'p',
        2 => 'q',
        3 => 's',
        4 => 't'
      }.freeze

      attr_reader :lat, :lng, :depth

      def initialize(point, depth: DEPTH)
        @lat   = point.lat
        @lng   = point.lng
        @depth = depth
      end

      def call
        tile_displacement_enumerator.take(depth).map do |tile|
          TILE_MAPPING[tile]
        end.join
      end

      private

      def tile_displacement_enumerator
        Sequence.call(
          lat: lat,
          lng: lng
        )
      end
    end
  end
end
