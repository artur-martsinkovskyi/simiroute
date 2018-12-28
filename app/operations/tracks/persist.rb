# frozen_string_literal: true

require 'dry/transaction/operation'

module Tracks
  class Persist
    include Dry::Transaction::Operation
    # This requires performance tests and consideration to pick
    # the most optimal batch size, but for now I just picked a
    # value from the top of my head.
    BATCH_SIZE = 2000

    def call(input)
      track = Track.new(input[:track_attributes])
      track.save
      points = input[:points_attributes].map do |point_attrs|
        point_attrs[:track_id] = track.id
        point_attrs
      end

      Point.import(points, batch_size: BATCH_SIZE)
      Success(track)
    end
  end
end
