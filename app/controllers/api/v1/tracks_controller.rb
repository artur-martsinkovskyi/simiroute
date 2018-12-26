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

      private

      def resource
        @resource ||= Track.find(params[:id])
      end
    end
  end
end