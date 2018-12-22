require_relative '../support/points_helper'

FactoryBot.define do
  factory :track do
    track_attachment { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'sample.gpx'), 'application/text') }


    after(:create) do |track|
      track.points.create(PointsHelper.point_attributes)
    end
  end
end
