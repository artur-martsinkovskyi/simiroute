class TrackBlueprint < Blueprinter::Base
  identifier :id
  field :uuid

  view :minimal do
    association :points, blueprint: PointBlueprint, view: :minimal
  end

  view :full do
    field :track_attachment
    association :points, blueprint: PointBlueprint, view: :full
  end
end
