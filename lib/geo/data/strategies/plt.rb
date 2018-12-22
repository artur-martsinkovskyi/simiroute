# frozen_string_literal: true

require 'csv'
require_relative '../../trackpoint'
require_relative '../../utils'
require_relative 'base'

module Geo
  module Data
    module Strategies
      class Plt < Base
        include Utils

        private

        def retrieve_data
          trackpoint_attributes.map do |trackpoint|
            Geo::Trackpoint.new(
              lat: trackpoint[0],
              lon: trackpoint[1],
              tracked_at: Time.parse("#{@date}T#{trackpoint[-1]}").utc,
              altitude: foot_to_meter(trackpoint[3].to_f)
            )
          end
        end

        def trackpoint_attributes
          index = 0
          utf_forced_content.each_line.with_object([]) do |line, result|
            if index < 6
              @date = line.strip.split(',')[3][0..9].tr('_', '-') if index == 4
              index += 1
            else
              result << line.strip.split(',')
            end
          end
        end

        def utf_forced_content
          content.encode(
            'UTF-8',
            'binary',
            invalid: :replace,
            undef: :replace,
            replace: ''
          )
        end
      end
    end
  end
end
