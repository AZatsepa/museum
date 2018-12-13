# frozen_string_literal: true

require 'capybara/poltergeist'
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, phantomjs: Phantomjs.path, js_errors: false)
end

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
