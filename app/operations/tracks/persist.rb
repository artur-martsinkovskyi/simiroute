# frozen_string_literal: true

require 'dry/transaction/operation'

module Tracks
  class Persist
    include Dry::Transaction::Operation

    def call(input)
      track = Track.new(input)
      track.save
      Success(track)
    end
  end
end
