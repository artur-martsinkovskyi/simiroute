class AddUserIdToTrack < ActiveRecord::Migration[5.2]
  def change
    add_reference :tracks, :user, index: true
  end
end
