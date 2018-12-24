# frozen_string_literal: true

module Api
  module V1
    class BaseController < ActionController::API
      extend Api::BlueprinterAutoviews
    end
  end
end
