# frozen_string_literal: true

module Tracks
  class CreateTrack
    include Dry::Transaction(container: Tracks::Container)

    step :validate, with: 'tracks.validate'
    step :create, with: 'tracks.create'
  end
end
