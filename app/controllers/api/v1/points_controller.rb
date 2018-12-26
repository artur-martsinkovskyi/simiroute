# frozen_string_literal: true

module Api
  module V1
    class PointsController < BaseController
      blueprinter_views_for :point

      def index
        @points = parent.points
        render json: PointBlueprint.render(@points, view: view)
      end

      def for_map
        @points = DecimatedQuery.new(parent.points).call
        render json: PointBlueprint.render(@points, view: view)
      end

      private

      def parent
        @parent ||= Track.find(params[:track_id])
      end
    end
  end
end