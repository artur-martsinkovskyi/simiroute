# frozen_string_literal: true

module Tracks
  class CreateTrack
    include Dry::Transaction(container: Tracks::Container)

    step :validate, with: 'tracks.validate'
    step :retrieve_points, with: 'tracks.retrieve_points'
    step :calculate_distance, with: 'tracks.calculate_distance'
    step :persist, with: 'tracks.persist'
  end
end
