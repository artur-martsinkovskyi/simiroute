# frozen_string_literal: true

class TrackBlueprint < Blueprinter::Base
  identifier :id
  field :uuid
  MINIMAL = :minimal
  FULL    = :full
  VIEWS   = [MINIMAL, FULL].freeze

  view :minimal do
    association :points, blueprint: PointBlueprint
  end

  view :full do
    field :track_attachment
    association :points, blueprint: PointBlueprint, view: :full
  end
end
