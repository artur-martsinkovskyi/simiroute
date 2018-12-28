# frozen_string_literal: true

module Api
  module V1
    class TracksController < BaseController
      blueprinter_views_for :track

      def show
        render json: TrackBlueprint.render(resource, view: view)
      end

      def index
        @tracks = Track.all
        render json: TrackBlueprint.render(@tracks, view: view)
      end

      def compare
        @track1 = Track.includes(:points).find(params[:track1])
        @track2 = Track.includes(:points).find(params[:track2])
        @comparison_result = Tracks::Compare.new(@track1, @track2).call

        render json: {
          points: PointBlueprint.render_as_hash(@comparison_result[:points]),
          similarity: @comparison_result[:similarity]
        }
      end

      private

      def resource
        @resource ||= Track.find(params[:id])
      end
    end
  end
end
