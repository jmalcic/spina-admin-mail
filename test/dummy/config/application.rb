# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require 'spina/admin/mail'
require 'dotenv-rails'

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    Dotenv.load('../../.env')
    config.load_defaults 6.0
    config.action_mailer.preview_path = "#{Spina::Admin::Mail::Engine.root}/test/mailers/previews"
    config.action_mailer.default_url_options = { host: 'test' }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
