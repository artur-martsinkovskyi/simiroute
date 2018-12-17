# frozen_string_literal: true

require 'English'
require_relative '../exceptions/parse_error'

module Geo
  module Data
    module Strategies
      class Base
        attr_accessor :content

        def initialize(content)
          @content = content
        end

        def call
          retrieve_data
        rescue StandardError
          raise Exceptions::ParseError
        end
      end
    end
  end
end
