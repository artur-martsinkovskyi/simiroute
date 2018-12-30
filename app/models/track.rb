# frozen_string_literal: true

class Track < ApplicationRecord
  belongs_to :user
  has_many :points, dependent: :destroy
  before_create -> { self.uuid = SecureRandom.base64 }

  validates :track_attachment, presence: true

  mount_uploader :track_attachment, TrackAttachmentUploader

  accepts_nested_attributes_for :points

  def name
    "#{File.basename(track_attachment.path)} - #{uuid}"
  end
end
