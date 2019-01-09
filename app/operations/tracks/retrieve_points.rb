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

      trackpoints_by_displacement = Hash.new { |h, key| h[key] = [] }

      parser
        .call
        .each_with_object(trackpoints_by_displacement) do |trackpoint, result|
          displacement_sequence =
            Geo::Displacement::PointMappingGenerator.new(trackpoint).call
          attrs = trackpoint.attributes

          attrs[:displacement_sequence] = displacement_sequence
          attrs[:uniq_by_displacement] = !result.key?(displacement_sequence)

          result[displacement_sequence] << attrs
        end

      trackpoints_by_displacement.values.flatten
    end
  end
end
