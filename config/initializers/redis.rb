url = ENV['REDIS_URL'] || Rails.application.credentials[Rails.env]&.dig(:redis_url) || 'redis://localhost:6379/1'
$redis = Redis.new(url: url)
