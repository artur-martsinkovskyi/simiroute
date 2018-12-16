# frozen_string_literal: true

require_relative 'base_error'

module Geo
  module Data
    module Exceptions
      class ParseError < BaseError
        MESSAGE = 'File cannot be parsed due to schema inconsistencies or wrong file format.'
        def initialize(msg = MESSAGE)
          super
        end
      end
    end
  end
end
