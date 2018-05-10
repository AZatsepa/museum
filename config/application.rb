require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)
Dotenv::Railtie.load if Rails.env.test? || Rails.env.development?

module Museum
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec, fixtures: true,
                               view_spec: false,
                               helper_specs: false,
                               routing_specs: false,
                               request_specs: false,
                               controller_specs: true
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
  end
end
