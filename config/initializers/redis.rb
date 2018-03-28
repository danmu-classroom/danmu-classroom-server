# set ENV[:REDIS_HOST] and ENV[:REDIS_PORT]
$redis = Redis.new(host: ENV.fetch('REDIS_HOST') { 'localhost' },
                   port: ENV.fetch('REDIS_PORT') { 6379 })
