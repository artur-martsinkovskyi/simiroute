# frozen_string_literal: true

TrackSchema = Dry::Validation.Schema do
  required(:track_attachment).filled
  required(:user_id).filled
end
