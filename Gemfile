source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'execjs'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'paperclip'
gem 'pg', '~> 0.18'
gem 'pg_search'
gem 'puma',         '~> 3.0'
gem 'rails',        '~> 5.0.1'
gem 'sass-rails',   '~> 5.0'
gem 'turbolinks',   '~> 5'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier', '>= 1.3.0'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'listen',                '~> 3.0.5'
  gem 'rubocop',               '~> 0.49.1', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console',           '>= 3.3.0'
end

ruby '2.4.1'
