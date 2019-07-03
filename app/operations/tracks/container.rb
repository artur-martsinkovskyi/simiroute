# frozen_string_literal: true

module Tracks
  class Container
    extend Dry::Container::Mixin

    namespace 'tracks' do
      register 'validate' do
        Tracks::Validate.new
      end

      register 'retrieve_points' do
        Tracks::RetrievePoints.new
      end

      register 'calculate_distance' do
        Tracks::CalculateDistance.new
      end

      register 'persist' do
        Tracks::Persist.new
      end
    end
  end
end
