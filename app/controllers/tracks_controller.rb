# frozen_string_literal: true

class TracksController < ApplicationController
  def index
    @tracks = Track.all
  end

  def show
    @track = Track.includes(:points).find(params[:id])
  end

  def new
    @track = Track.new
  end

  def create
    @track = TrackBuilder.build(permitted_params)
    if @track.save
      redirect_to tracks_path
    else
      render :new
    end
  end

  private

  def permitted_params
    params.require(:track).permit(:track_attachment)
  end
end
