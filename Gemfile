source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.7.1'

gem 'rails', '~> 5.2.3'

# Rails default gems
gem 'jbuilder', '~> 2.10' # Build JSON APIs, https://github.com/rails/jbuilder
gem 'pg', '~> 1.2' # Active Record Postgresql
gem 'puma', '~> 4.3' # App server
gem 'redis', '~> 4.2' # Cache database
gem 'sass-rails', '~> 5.1' # SCSS
gem 'turbolinks', '~> 5.2' # https://github.com/turbolinks/turbolinks
gem 'uglifier', '~> 4.2' # Uglifier as compressor for JavaScript assets
gem 'bootsnap', '~> 1.4', require: false # Speed up booting, # https://github.com/Shopify/bootsnap

# Append gems
gem 'devise', '~> 4.7' # User Authentication
gem 'font-awesome-sass', '~> 5.13' # Icons
gem 'http', '~> 4.4' # HTTP Client
gem 'line-bot-api', '~> 1.14' # Line Bot
gem 'line-bot-message-builder', '~> 0.1.2' # Line Bot Message Builder
gem 'rails-i18n', '~> 5.1' # I18n
gem 'simple_form', '~> 5.0' # Form Builder

group :development, :test do
  gem 'byebug', '~> 11.1', platforms: %i[mri mingw x64_mingw] # Debugger
  gem 'capybara', '~> 3.32' # System testing
  gem 'selenium-webdriver', '~> 3.142' # Selenium
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rails-erd', '~> 1.6'
  gem 'spring' # https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', '~> 0.85.1' # Formater 
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '~> 1.2020', platforms: %i[mingw mswin x64_mingw jruby]
