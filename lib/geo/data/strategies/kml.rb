# frozen_string_literal: true

require 'ox'
require_relative '../../trackpoint'

module Geo
  module Data
    module Strategies
      class Kml
        attr_reader :xml_content

        def initialize(xml_content)
          @xml_content = xml_content
        end

        def call
          trackpoint_data.map do |trackpoint|
            Geo::Trackpoint.new(
              lat: trackpoint[:LookAt][:latitude],
              lon: trackpoint[:LookAt][:longitude],
              time: Time.parse(trackpoint[:TimeStamp][:when]),
              altitude: trackpoint[:Point][:coordinates].split(',')[2]
            )
          end
        end

        private

        def trackpoint_data
          xml_hash[:kml][1][:Document][:Folder][1][:Folder][:Folder][:Placemark]
        end

        def xml_hash
          @xml_hash ||= Ox.load(xml_content, mode: :hash)
        end
      end
    end
  end
end
