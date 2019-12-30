source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2.3'

# Rails default gems
gem 'bootsnap', require: false # Speed up booting, # https://github.com/Shopify/bootsnap
gem 'jbuilder', '~> 2.5' # Build JSON APIs, https://github.com/rails/jbuilder
gem 'pg', '>= 0.18', '< 2.0' # Active Record Postgresql
gem 'puma', '~> 3.12' # App server
gem 'redis', '~> 4.1' # Cache database
gem 'sass-rails', '~> 5.0' # SCSS
gem 'turbolinks', '~> 5' # https://github.com/turbolinks/turbolinks
gem 'uglifier', '>= 1.3.0' # Uglifier as compressor for JavaScript assets

# Append gems
gem 'devise', '>= 4.7.1' # User Authentication
gem 'font-awesome-sass', '~> 5.5.0' # Icons
gem 'http' # HTTP Client
gem 'line-bot-api' # Line Bot
gem 'line-bot-message-builder', '~> 0.1.2' # Line Bot Message Builder
gem 'rails-i18n', '~> 5.1' # I18n
gem 'simple_form' # Form Builder

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw] # Debugger
  gem 'capybara', '~> 2.13' # System testing
  gem 'selenium-webdriver' # selenium driver
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-rails'
  gem 'rails-erd'
  gem 'spring' # https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
