# frozen_string_literal: true

class Track < ApplicationRecord
  has_many :points, dependent: :destroy
  before_create -> { self.uuid = SecureRandom.base64 }

  mount_uploader :track_attachment, TrackAttachmentUploader

  accepts_nested_attributes_for :points
end
