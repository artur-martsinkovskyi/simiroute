# frozen_string_literal: true

module Tracks
  class CreateTrack
    include Dry::Transaction(container: Tracks::Container)

    step :validate, with: 'tracks.validate'
    step :retrieve_points, with: 'tracks.retrieve_points'
    step :persist, with: 'tracks.persist'
  end
end
