ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'capybara/poltergeist'
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!
SimpleCov.start

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include I18nMacros
  config.include Warden::Test::Helpers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!


  config.before(:suite)              { DatabaseCleaner.clean_with(:truncation) }
  config.before(:each)               { DatabaseCleaner.strategy = :transaction }
  config.before(:each, js: true)     { DatabaseCleaner.strategy = :truncation }
  config.before(:each)               { DatabaseCleaner.start }
  config.after(:each)                { DatabaseCleaner.clean }

  config.use_transactional_fixtures = false

  Capybara.javascript_driver = :poltergeist

  # if ENV['SELENIUM_REMOTE_HOST']
  #   Capybara.register_driver :selenium_remote_firefox do |app|
  #     Capybara::Selenium::Driver.new(
  #       app,
  #       browser: :remote,
  #       url: "http://#{ENV['SELENIUM_REMOTE_HOST']}:4444/wd/hub")
  #   end
  #   Capybara.javascript_driver = :selenium_remote_firefox
  # else
  #   Capybara.register_driver :selenium do |app|
  #     Capybara::Selenium::Driver.new(app)
  #   end
  #   Capybara.javascript_driver = :selenium
  #   Selenium::WebDriver::Firefox::Binary.path = ENV['FIREFOX_BINARY_PATH'] || '/usr/bin/firefox'
  # end


  # config.before(:each) do
  #   DatabaseCleaner.start
  #   DatabaseCleaner.strategy = :transaction
  #   if /selenium_remote/.match Capybara.current_driver.to_s
  #     ip = `/sbin/ip route|awk '/scope/ { print $9 }'`
  #     ip = ip.gsub "\n", ""
  #     Capybara.server_port = '3000'
  #     Capybara.server_host = ip
  #     Capybara.app_host = "http://#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}"
  #   end
  # end

  # config.after(:each) do
  #   DatabaseCleaner.clean
  #   Capybara.reset_sessions!
  #   Capybara.use_default_driver
  #   Capybara.app_host = nil
  # end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
