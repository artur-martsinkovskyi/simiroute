# frozen_string_literal: true

require_relative 'strategies/gpx'
require_relative 'strategies/kml'
require_relative 'exceptions/unknown_extension_error'
require_relative 'exceptions/unknown_mime_type_error'
require_relative 'constants'
require 'mimemagic'

module Geo
  module Data
    class Parser
      STRATEGIES = [
        Strategies::Gpx,
        Strategies::Kml
      ].freeze

      attr_reader :file

      def initialize(file)
        @file = file
      end

      def call
        strategy.new(file.read).call
      end

      private

      def strategy
        unless Constants::ALLOWED_MIME_TYPES.include?(mime_type)
          raise Exceptions::UnknownMimeTypeError,
                "Cannot parse files with #{mime_type || 'unknown'} mime type."
        end
        STRATEGIES.find { |strategy| strategy.can_process?(extname) }
      end

      def extname
        @extname ||= File.extname(file.path)[1..-1]
      end

      def mime_type
        @mime_type ||= MimeMagic.by_path(file.path)&.type
      end
    end
  end
end
