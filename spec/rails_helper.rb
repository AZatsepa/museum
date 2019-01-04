ENV['RAILS_ENV'] ||= 'test'
ENV['NODE_ENV'] = ENV['RAILS_ENV']
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'cancan/matchers'
require 'webmock/rspec'
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each(&method(:require))
ActiveRecord::Migration.maintain_test_schema!
SimpleCov.start('rails') do
  add_filter do |source_file|
    source_file.lines.count < 5
  end
end
WebMock.disable_net_connect!(allow_localhost: true)
Bullet.enable = true
Bullet.raise = true
Bullet.bullet_logger = true
Bullet.rails_logger = true

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include I18nMacros
  config.extend I18nMacros
  config.include Warden::Test::Helpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.use_transactional_fixtures = true

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  if Bullet.enable?
    config.before do
      Bullet.start_request
    end

    config.after do
      Bullet.perform_out_of_channel_notifications if Bullet.notification?
      Bullet.end_request
    end

    config.around(disable_bullet: true) do |example|
      Bullet.enable = false
      example.run
      Bullet.enable = true
    end
  end

  Capybara.server = :puma, { Silent: true }
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

FactoryBot::SyntaxRunner.class_eval do
  include ActionDispatch::TestProcess
end
