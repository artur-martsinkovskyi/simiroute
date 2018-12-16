require Rails.root.join('lib', 'geo', 'data', 'exceptions', 'unknown_extension_error')
require Rails.root.join('lib', 'geo', 'data', 'exceptions', 'parse_error')

TrackSchema = Dry::Validation.Schema do
  required(:track_attachment).filled
end

module Tracks
  class Create
    include Dry::Transaction

    step :validate
    step :create

    def validate(input)
      validation = TrackSchema.(input)
      if validation.success?
        Success(input)
      else
        Failure(validation.errors)
      end
    end

    def create(input)
      track = TrackBuilder.create(input)
      Success(track)

    rescue Geo::Data::Exceptions::UnknownExtensionError,
           Geo::Data::Exceptions::ParseError => e
      Failure(track_attachment: e.message)
    end
  end
end
