# frozen_string_literal: true

RSpec.configure do
  Capybara.javascript_driver = :selenium_chrome_headless
  # Capybara.javascript_driver = :selenium_chrome # use it if you want to see steps
end
