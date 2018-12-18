# frozen_string_literal: true

require Rails.root.join(
  'lib', 'geo', 'data', 'exceptions', 'unknown_extension_error'
)
require Rails.root.join('lib', 'geo', 'data', 'exceptions', 'parse_error')
require 'dry/transaction/operation'

module Tracks
  class Create
    include Dry::Transaction::Operation

    def call(input)
      track = TrackBuilder.create(input)
      Success(track)
    rescue Geo::Data::Exceptions::UnknownExtensionError,
           Geo::Data::Exceptions::ParseError => e
      Failure(track_attachment: e.message)
    end
  end
end
