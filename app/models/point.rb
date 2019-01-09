# frozen_string_literal: true

class Point < ApplicationRecord
  belongs_to :track

  scope :uniq_by_displacement, -> { where(uniq_by_displacement: true) }
end
