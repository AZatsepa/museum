# frozen_string_literal: true

require 'capybara/webkit'

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.before(:suite)              { DatabaseCleaner.clean_with(:truncation) }
  config.before(:each)               { DatabaseCleaner.strategy = :transaction }
  config.before(:each, js: true)     { DatabaseCleaner.strategy = :truncation }
  config.before(:each)               { DatabaseCleaner.start }
  config.after(:each)                { DatabaseCleaner.clean }

  Capybara.javascript_driver = :webkit
  Capybara.server = :puma
  Capybara::Webkit.configure do |capybara_config|
    capybara_config.allow_url('netdna.bootstrapcdn.com')
    capybara_config.allow_url('http://fonts.googleapis.com')
  end
end
