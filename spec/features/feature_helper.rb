require 'capybara/webkit'
require 'capybara/poltergeist'

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.before(:suite)              { DatabaseCleaner.clean_with(:truncation) }
  config.before(:each)               { DatabaseCleaner.strategy = :transaction }
  config.before(:each, js: true)     { DatabaseCleaner.strategy = :truncation }
  config.before(:each)               { DatabaseCleaner.start }
  config.after(:each)                { DatabaseCleaner.clean }

  if ENV['CAPYBARA_DRIVER'].present?
    Capybara.javascript_driver = ENV['CAPYBARA_DRIVER'].to_sym
  else
    Capybara.javascript_driver = :webkit
    Capybara::Webkit.configure do |capybara_config|
      capybara_config.allow_url('netdna.bootstrapcdn.com')
      capybara_config.allow_url('http://fonts.googleapis.com')
    end
  end
end
