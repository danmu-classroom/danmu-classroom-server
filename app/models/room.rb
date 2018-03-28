class Room < ApplicationRecord
  before_create do
    generate_key
    setup_redis_channel
    active_room
  end

  after_create do
    first_publish_to_redis
  end

  private

  def generate_key
    self.key ||= SecureRandom.hex(3)
  end

  def setup_redis_channel
    host = ENV.fetch('REDIS_HOST') { 'localhost' }
    port = ENV.fetch('REDIS_PORT') { 6379 }
    self.redis = "#{host}:#{port}"
    self.channel = "#{self.key}_#{created_at.to_i}"
  end

  def active_room
    self.online ||= true
  end

  def first_publish_to_redis
    $redis.publish self.channel, 'Room Created.'
    logger.info "publish channel: #{self.channel}, message: Room Created."
  end
end
