class Danmu < ApplicationRecord
  belongs_to :room
  belongs_to :sender

  validate do
    errors.add(:base, 'Room is offline, can not add new danmu.') unless room.online?
  end

  after_create do
    publish
  end

  def publish
    $redis.publish(room.channel, content)
    Rails.logger.debug { "publish to channel: #{room.channel}, message: #{content}" }
  end
end
