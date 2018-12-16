# frozen_string_literal: true

class TracksController < ApplicationController
  def index
    @tracks = Track.order(:id).page(params[:page])
  end

  def show
    @track  = Track.includes(:points).find(params[:id])
    @points = @track.points.page(params[:page])
  end

  def new
    @errors = {}
  end

  def create
    transaction = Tracks::Create.new
    transaction.(permitted_params) do |result|
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
    params.fetch(:track, {}).permit(:track_attachment)
  end
end
