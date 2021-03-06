# frozen_string_literal: true

class TracksController < ApplicationController
  before_action :require_login, only: %i[
    new create compare
  ]

  def index
    @tracks = Track.order(:id).page(params[:page])
  end

  def show
    @track  = Track.includes(:points).find(params[:id])
    @points = @track.points.page(params[:page])
  end

  def compare
    @tracks = Track.all
  end

  def new
    @errors = {}
  end

  def create
    transaction = Tracks::CreateTrack.new
    transaction.call(permitted_params) do |result|
      result.success do |track|
        redirect_to track_path(track)
      end
      result.failure do |errors|
        @errors = errors
        render :new
      end
    end
  end

  private

  def permitted_params
    params.fetch(:track, {})
          .permit(:track_attachment)
          .merge(user_id: current_user.id)
  end
end
