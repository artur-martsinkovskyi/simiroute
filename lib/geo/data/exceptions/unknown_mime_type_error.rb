# frozen_string_literal: true

require_relative 'base_error'

module Geo
  module Data
    module Exceptions
      class UnknownMimeTypeError < BaseError
        MESSAGE = 'Cannot parse file with unknown mime type.'
        def initialize(msg = MESSAGE)
          super
        end
      end
    end
  end
end
