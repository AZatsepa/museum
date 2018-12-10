# frozen_string_literal: true

require 'capybara/poltergeist'

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    Webpacker.compile
  end
  config.before                       { DatabaseCleaner.strategy = :transaction }
  config.before(:each, js: true)      { DatabaseCleaner.strategy = :truncation }
  config.before                       { DatabaseCleaner.start }
  config.after                        { DatabaseCleaner.clean }

  Capybara.javascript_driver = :poltergeist
end
