# frozen_string_literal: true

module Api
  module BlueprinterAutoviews
    VIEW_FALLBACK = :default
    extend ActiveSupport::Concern

    included do
      def self.blueprinter_views_for(model, view_fallback: VIEW_FALLBACK)
        blueprinter_class = "#{model.to_s.capitalize}Blueprint".constantize
        define_method :view do
          blueprinter_class::VIEWS.find do |view|
            view.to_s == params[:view]
          end || view_fallback
        end
      end
    end
  end
end
