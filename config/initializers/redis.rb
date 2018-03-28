# set ENV[:REDIS_HOST] and ENV[:REDIS_PORT]
$redis = Redis.new(url: ENV['REDIS_URL'])
