# frozen_string_literal: true

module Geo
  module Utils
    module_function

    FOOT_TO_METER_TRANSITION_SCALE = 3.281

    def foot_to_meter(foot)
      foot / FOOT_TO_METER_TRANSITION_SCALE
    end
  end
end
