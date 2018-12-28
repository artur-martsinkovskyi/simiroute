# frozen_string_literal: true

module Geo
  module Data
    module Constants
      TEXT_KML   = 'application/vnd.google-earth.kml+xml'
      TEXT_GPX   = 'application/gpx+xml'
      ALLOWED_MIME_TYPES = [
        TEXT_KML,
        TEXT_GPX
      ].freeze

      GPX = 'gpx'
      KML = 'kml'
      ALLOWED_FILE_EXTENSIONS = [
        GPX,
        KML
      ].freeze
    end
  end
end
