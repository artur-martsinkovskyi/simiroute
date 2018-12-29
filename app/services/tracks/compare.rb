# frozen_string_literal: true

module Tracks
  class Compare
    def initialize(track1, track2)
      @track1 = track1
      @track2 = track2
    end

    def call
      {
        points: points,
        similarity: similarity
      }
    end

    private

    def points
      @points ||= @track1.points.select do |point|
        @track2.points.any? do |other_point|
          other_point.displacement_sequence == point.displacement_sequence
        end
      end
    end

    def similarity
      [
        track1_to_track2_similarity,
        track2_to_track1_similarity
      ]
    end

    def track1_to_track2_similarity
      (points.size / (@track1.points.size / 100.0)).round(2)
    end

    def track2_to_track1_similarity
      (points.size / (@track2.points.size / 100.0)).round(2)
    end
  end
end
