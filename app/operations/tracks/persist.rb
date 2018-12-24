# frozen_string_literal: true

require 'dry/transaction/operation'

module Tracks
  class Persist
    include Dry::Transaction::Operation

    def call(input)
      track = Track.new(input[:track_attributes])
      track.save
      points = input[:points_attributes].map do |point_attrs|
        point_attrs[:track_id] = track.id
        point_attrs
      end

      Point.import(points)
      Success(track)
    end
  end
end
