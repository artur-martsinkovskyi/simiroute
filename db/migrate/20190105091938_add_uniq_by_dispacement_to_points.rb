class AddUniqByDispacementToPoints < ActiveRecord::Migration[5.2]
  def change
    add_column :points, :uniq_by_displacement, :boolean, default: false
  end
end
