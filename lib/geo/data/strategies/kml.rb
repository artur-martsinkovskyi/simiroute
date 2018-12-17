# frozen_string_literal: true

require 'ox'
require_relative '../../trackpoint'
require_relative 'base'

module Geo
  module Data
    module Strategies
      class Kml < Base
        private

        def retrieve_data
          trackpoint_attributes.map do |trackpoint|
            Geo::Trackpoint.new(
              lat: trackpoint[:LookAt][:latitude],
              lon: trackpoint[:LookAt][:longitude],
              time: Time.parse(trackpoint[:TimeStamp][:when]).utc,
              altitude: trackpoint[:Point][:coordinates].split(',')[2]
            )
          end
        end

        def trackpoint_attributes
          data_hash[:kml][1][:Document][:Folder][1].dig(
            :Folder,
            :Folder,
            :Placemark
          )
        end

        def data_hash
          @data_hash ||= Ox.load(content, mode: :hash)
        end
      end
    end
  end
end
