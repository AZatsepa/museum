# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Museum
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    config.generators do |g|
      g.test_framework :rspec, fixtures: true,
                               view_spec: false,
                               helper_specs: false,
                               routing_specs: false,
                               request_specs: false,
                               controller_specs: true
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0
    config.paths.add Rails.root.join('lib', 'forms').to_s, eager_load: true
  end
end
