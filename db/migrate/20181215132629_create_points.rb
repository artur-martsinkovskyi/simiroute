# frozen_string_literal: true

class CreatePoints < ActiveRecord::Migration[5.2]
  def change
    create_table :points do |t|
      t.float      :altitude
      t.float      :lat
      t.float      :lon
      t.date       :time
      t.references :track
    end
  end
end
