# frozen_string_literal: true

class CreatePoints < ActiveRecord::Migration[5.2]
  def change
    create_table :points do |t|
      t.float      :altitude
      t.float      :lat
      t.float      :lon
      t.datetime   :tracked_at
      t.references :track
    end
  end
end
