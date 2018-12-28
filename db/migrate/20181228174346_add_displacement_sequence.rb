class AddDisplacementSequence < ActiveRecord::Migration[5.2]
  def change
    add_column :points, :displacement_sequence, :string
  end
end
