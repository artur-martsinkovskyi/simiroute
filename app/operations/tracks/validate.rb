# frozen_string_literal: true

require 'dry/transaction/operation'

module Tracks
  class Validate
    include Dry::Transaction::Operation

    def call(input)
      validation = TrackSchema.call(input)
      if validation.success?
        Success(input)
      else
        Failure(validation.errors)
      end
    end
  end
end
