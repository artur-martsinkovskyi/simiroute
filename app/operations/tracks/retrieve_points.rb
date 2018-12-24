# frozen_string_literal: true

require Rails.root.join('lib', 'geo', 'data', 'parser')
require Rails.root.join('lib', 'geo', 'data', 'exceptions', 'base_error')
require 'dry/transaction/operation'

module Tracks
  class RetrievePoints
    include Dry::Transaction::Operation

    def call(track_attributes)
      file = track_attributes[:track_attachment]
      parser = Geo::Data::Parser.new(file)
      points_attributes = parser.call.map(&:attributes)

      Success(
        track_attributes: track_attributes,
        points_attributes: points_attributes
      )
    rescue Geo::Data::Exceptions::BaseError => e
      Failure(track_attachment: e.message)
    end
  end
end
