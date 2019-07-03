# frozen_string_literal: true

require Rails.root.join('lib', 'geo', 'data', 'parser')
require Rails.root.join('lib', 'geo', 'data', 'exceptions', 'base_error')
require Rails.root.join('lib', 'geo', 'displacement', 'point_mapping_generator')
require 'dry/transaction/operation'

module Tracks
  class CalculateDistance
    include Dry::Transaction::Operation

    def call(attributes)
      Success(
        **attributes,
        track_attributes: attributes[:track_attributes].merge(distance: distance(attributes)),
      )
    end

    private

    def distance(attributes)
      points_attributes = attributes[:points_attributes]
      distance_lambda = Lambdas::DistanceLambda.new

      distance_lambda.call(payload: points_attributes)
    end
  end
end
