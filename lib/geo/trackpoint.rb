# frozen_string_literal: true

require 'dry-struct'
require_relative 'types'

module Geo
  class Trackpoint < Dry::Struct
    attribute :lat, Types::Coercible::Float
    attribute :lng, Types::Coercible::Float
    attribute :altitude, Types::Coercible::Float
    attribute :tracked_at, Types::Strict::Time
  end
end
