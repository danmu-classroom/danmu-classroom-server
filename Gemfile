# frozen_string_literal: true

source 'https://rubygems.org'

ruby file: '.ruby-version'

gem 'rails', '~> 8.1.4'

# Rails default gems
gem 'bootsnap', require: false # Speed up booting, https://github.com/Shopify/bootsnap
gem 'cssbundling-rails' # Bootstrap 5 / Sass via yarn, https://github.com/rails/cssbundling-rails
gem 'importmap-rails' # JavaScript with ESM import maps, https://github.com/rails/importmap-rails
gem 'jbuilder' # Build JSON APIs, https://github.com/rails/jbuilder
gem 'pg', '~> 1.6' # Active Record Postgresql
gem 'propshaft' # Asset pipeline, https://github.com/rails/propshaft
gem 'puma', '>= 6.0' # App server
gem 'redis', '~> 5.4' # Danmu queue and LINE sender state
gem 'stimulus-rails' # https://stimulus.hotwired.dev
gem 'turbo-rails' # https://turbo.hotwired.dev

# Append gems
gem 'devise', '~> 5.0' # User Authentication
gem 'line-bot-api', '~> 2.11' # Line Bot
gem 'rails-i18n', '~> 8.1' # I18n
gem 'simple_form', '~> 5.4' # Form Builder

group :development, :test do
  gem 'brakeman', require: false # Static analysis for security vulnerabilities
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude' # Debugger
  gem 'rubocop-rails-omakase', require: false # Formatter, https://github.com/rails/rubocop-rails-omakase
end

group :development do
  gem 'htmlbeautifier'
  gem 'rails-erd'
  gem 'web-console'
end

group :test do
  gem 'capybara' # System testing
  gem 'selenium-webdriver'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]
