# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'active_model_serializers'
gem 'bootsnap', require: false
gem 'cancancan'
gem 'carrierwave'
gem 'coffee-rails'
gem 'devise'
gem 'doorkeeper'
gem 'execjs'
gem 'foreman'
gem 'gon'
gem 'jbuilder'
gem 'oj'
gem 'oj_mimic_json'
gem 'omniauth'
gem 'omniauth-facebook', '~> 5.0.0 '
gem 'omniauth-google-oauth2', '~> 0.5.3'
gem 'paperclip'
gem 'pg'
gem 'pg_search'
gem 'puma'
gem 'rails', '~> 5.2'
gem 'rails-i18n'
gem 'redcarpet'
gem 'sass-rails'
gem 'sentry-raven'
gem 'skim'
gem 'slim-rails'
gem 'turbolinks'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier'
gem 'unicorn'
gem 'webpacker'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'html2slim'
  gem 'listen'
  gem 'rubocop', require: false
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
end

group :test do
  gem 'capybara', path: '../capybara'
  gem 'capybara-selenium'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'json_spec'
  gem 'launchy'
  gem 'poltergeist'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'webmock'
end
ruby '2.5.1'
