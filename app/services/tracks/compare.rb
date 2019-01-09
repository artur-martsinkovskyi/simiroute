# frozen_string_literal: true

module Tracks
  class Compare
    def initialize(track1, track2)
      @track1 = track1
      @track2 = track2
    end

    def call
      {
        points: intersection_points,
        similarity: similarity
      }
    end

    private

    def intersection_points
      @intersection_points ||= points1.select do |point|
        points2.any? do |other_point|
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
      (intersection_points.size / (points1.size / 100.0)).round(2)
    end

    def track2_to_track1_similarity
      (intersection_points.size / (points2.size / 100.0)).round(2)
    end

    def points1
      @points1 ||= @track1.points.uniq_by_displacement
    end

    def points2
      @points2 ||= @track2.points.uniq_by_displacement
    end
  end
end
