# frozen_string_literal: true

class AddTrackAttachmentToTrack < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :track_attachment, :string
  end
end
