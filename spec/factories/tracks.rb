# frozen_string_literal: true

require_relative '../support/points_helper'

FactoryBot.define do
  factory :track do
    association :user
    track_attachment do
      Rack::Test::UploadedFile.new(
        Rails.root.join(
          'spec',
          'fixtures',
          'files',
          'sample.gpx'
        ),
        'application/text'
      )
    end

    after(:create) do |track|
      track.points.create(PointsHelper.point_attributes)
    end
  end
end
