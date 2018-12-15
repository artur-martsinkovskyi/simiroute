# frozen_string_literal: true

require 'csv'
require_relative '../../trackpoint'
require_relative '../../utils'

module Geo
  module Data
    module Strategies
      class Plt
        include Utils

        attr_reader :content

        def initialize(content)
          @content = content
        end

        def call
          trackpoint_data.map do |trackpoint|
            Geo::Trackpoint.new(
              lat: trackpoint[0],
              lon: trackpoint[1],
              time: Time.parse("#{@date}T#{trackpoint[-1]}"),
              altitude: foot_to_meter(trackpoint[3].to_f)
            )
          end
        end

        def trackpoint_data
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