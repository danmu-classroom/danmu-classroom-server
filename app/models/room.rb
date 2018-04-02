class Room < ApplicationRecord
  has_many :danmus

  before_create do
    generate_key
    setup_redis_channel
    active_room
  end

  validate do
    errors.add(:base, 'Rooms number reach the upper limit.') unless Room.empty_room?
  end

  after_create do
    publish 'Room Created.'
  end

  scope :online, -> { where(online: true) }

  def self.empty_room?
    online.size < (ENV.fetch('MAX_ROOM_NUMBER') { 20 }).to_i
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

  def publish(message)
    $redis.publish channel, message
    logger.debug "publish to channel: #{channel}, message: #{message}"
  end
end
