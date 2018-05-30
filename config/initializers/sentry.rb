# frozen_string_literal: true

if Rails.env.production?
  if ENV['SENTRY_DSN'].nil?
    Rails.logger.info 'No SENTRY_DSN available, skipping configuring sentry'
  else
    Raven.configure do |config|
      config.dsn = ENV['SENTRY_DSN']
    end
  end
end
