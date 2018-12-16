# frozen_string_literal: true

require_relative 'strategies/gpx'
require_relative 'strategies/kml'
require_relative 'strategies/plt'
require_relative 'exceptions/unknown_extension_error'

module Geo
  module Data
    class Parser
      attr_reader :file
      def initialize(file)
        @file = file
      end

      def call
        strategy.new(file.read).call
      end

      private

      def strategy
        case extname
        when 'gpx' then ::Geo::Data::Strategies::Gpx
        when 'kml' then ::Geo::Data::Strategies::Kml
        when 'plt' then ::Geo::Data::Strategies::Plt
        else
          raise Exceptions::UnknownExtensionError,
                "Cannot parse files with .#{extname} extension."
        end
      end

      def extname
        @extname ||= File.extname(file.path)[1..-1]
      end
    end
  end
end
