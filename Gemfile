# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'active_model_serializers'
gem 'aws-sdk-s3', require: false
gem 'bootsnap', require: false
gem 'cancancan'
gem 'coffee-rails'
gem 'devise', '>= 4.6.0'
gem 'doorkeeper', '~> 4.4.0'
gem 'execjs'
gem 'foreman'
gem 'gon'
gem 'i18n-js'
gem 'image_processing'
gem 'jbuilder'
gem 'kaminari'
gem 'mini_magick'
gem 'oj'
gem 'oj_mimic_json'
gem 'omniauth'
gem 'omniauth-facebook', '~> 5.0.0 '
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection', '~> 0.1'
gem 'pg'
gem 'pg_search'
gem 'puma'
gem 'rack'
gem 'rails', '~> 6.0.2.2'
gem 'rails-i18n'
gem 'rails_admin', '~> 2.0.2'
gem 'redcarpet'
gem 'sass-rails'
gem 'sentry-raven'
gem 'slim-rails'
gem 'turbolinks'
gem 'uglifier'
gem 'unicorn'
gem 'webpacker'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'capistrano', '~> 3.11', require: false
  gem 'capistrano-rails', '~> 1.4', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano3-puma', require: false
  gem 'html2slim'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :development, :test do
  gem 'bullet'
  gem 'bundle-audit'
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'i18n-tasks'
  gem 'letter_opener'
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
  gem 'slim_lint'
end

group :test do
  gem 'capybara'
  gem 'capybara-selenium'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'json_spec'
  gem 'launchy'
  gem 'phantomjs', require: 'phantomjs/poltergeist'
  gem 'poltergeist'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'webdrivers'
  gem 'webmock'
end
