# frozen_string_literal: true

require Rails.root.join('lib', 'geo', 'data', 'parser')
require Rails.root.join('lib', 'geo', 'data', 'exceptions', 'base_error')
require Rails.root.join('lib', 'geo', 'displacement', 'point_mapping_generator')
require 'dry/transaction/operation'

module Tracks
  class RetrievePoints
    include Dry::Transaction::Operation

    def call(track_attributes)
      file = track_attributes[:track_attachment]

      Success(
        track_attributes: track_attributes,
        points_attributes: points_attributes(file)
      )
    rescue Geo::Data::Exceptions::BaseError => e
      Failure(track_attachment: e.message)
    end

    private

    def points_attributes(file)
      parser = Geo::Data::Parser.new(file)

      parser.call.map do |trackpoint|
        attrs = trackpoint.attributes
        attrs[:displacement_sequence] =
          Geo::Displacement::PointMappingGenerator.new(trackpoint).call
        attrs
      end
    end
  end
end
