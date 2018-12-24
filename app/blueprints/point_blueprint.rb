# frozen_string_literal: true

class PointBlueprint < Blueprinter::Base
  identifier :id

  FULL    = :full
  VIEWS   = [FULL].freeze

  field :lat
  field :lng

  view FULL do
    field :altitude
    field :tracked_at
  end
end
