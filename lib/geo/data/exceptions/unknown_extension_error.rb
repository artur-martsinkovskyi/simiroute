# frozen_string_literal: true

require_relative 'base_error'

module Geo
  module Data
    module Exceptions
      class UnknownExtensionError < BaseError
        MESSAGE = 'Cannot parse file with unknown extension.'
        def initialize(msg = MESSAGE)
          super
        end
      end
    end
  end
end
