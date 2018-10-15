# frozen_string_literal: true

require 'capybara/poltergeist'

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.before(:suite)               { DatabaseCleaner.clean_with(:truncation) }
  config.before                       { DatabaseCleaner.strategy = :transaction }
  config.before(:each, js: true)      { DatabaseCleaner.strategy = :truncation }
  config.before                       { DatabaseCleaner.start }
  config.after                        { DatabaseCleaner.clean }

  # Capybara.javascript_driver = :poltergeist
  Capybara.register_driver :poltergeist_debug do |app|
    Capybara::Poltergeist::Driver.new(app, inspector: true)
  end

  Capybara.javascript_driver = :poltergeist_debug
end
