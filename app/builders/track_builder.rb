# frozen_string_literal: true

require Rails.root.join('lib', 'geo', 'data', 'parser')

class TrackBuilder
  private_class_method :new
  def initialize(attrs)
    @attributes = attrs
  end

  def self.create(attrs)
    build(attrs).tap(&:save)
  end

  def self.build(attrs)
    new(attrs).send(:build)
  end

  private

  def build
    track = Track.new(attributes)
    track.points.build(point_attributes)
    track
  end

  attr_reader :attributes

  def file
    attributes.fetch(:track_attachment)
  end

  def geo_data_parser
    Geo::Data::Parser.new(file)
  end

  def point_attributes
    geo_data_parser.call.map(&:attributes)
  end
end
