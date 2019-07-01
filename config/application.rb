# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Simiroute
  class Application < Rails::Application
    class SecretsEnvLoader
      LOCAL_CREDENTIALS = 'config/credentials.local.yml'.freeze

      def call
        secrets = local_credentials? ? local_credentials : secret_credentials
        return if secrets.blank?
        secrets.each { |key, value| ENV[key.to_s] ||= value.to_s }
      end

      private

      def local_credentials?
        Rails.env.development?
      end

      def local_credentials
        return unless File.exist?(LOCAL_CREDENTIALS)
        YAML.safe_load(File.read(LOCAL_CREDENTIALS))
      end

      def secret_credentials
        Rails.application.credentials.public_send(Rails.env)
      end
    end
    SecretsEnvLoader.new.call
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil
    # Change logging
  end
end
