# frozen_string_literal: true

if Rails.env.production?
  if Rails.application.credentials[:sentry_dsn].nil?
    Rails.logger.info 'No SENTRY_DSN available, skipping configuring sentry'
  else
    Raven.configure do |config|
      config.dsn = Rails.application.credentials[Rails.env.to_sym][:sentry_dsn]
    end
  end
end
