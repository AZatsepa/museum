require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)
Dotenv::Railtie.load if Rails.env.test? || Rails.env.development?

module Museum
  class Application < Rails::Application
  end
end
