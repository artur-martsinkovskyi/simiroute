class PointBlueprint < Blueprinter::Base
  identifier :id

  view :minimal do
    field :lat
    field :lng
  end

  view :full do
    include_view :minimal
    field :altitude
    field :tracked_at
  end
end
