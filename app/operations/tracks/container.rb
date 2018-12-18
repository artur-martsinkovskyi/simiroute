# frozen_string_literal: true

module Tracks
  class Container
    extend Dry::Container::Mixin

    namespace 'tracks' do
      register 'validate' do
        Tracks::Validate.new
      end

      register 'create' do
        Tracks::Create.new
      end
    end
  end
end
