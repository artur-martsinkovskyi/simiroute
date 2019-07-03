class AddDistanceToTracks < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :distance, :float, default: 0
  end
end
