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
    self.redis = ENV['REDIS_URL']
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
