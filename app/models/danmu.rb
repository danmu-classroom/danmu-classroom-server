class Danmu < ApplicationRecord
  belongs_to :room
  belongs_to :sender

  validates_presence_of :content
  validate do
    errors.add(:base, 'Room is offline, can not add new danmu.') unless room.online?
  end

  after_create do
    $redis.lpush "room_#{room_id}", to_h.to_json
  end

  def to_h
    { content: content.to_s, created_at: created_at }
  end
end
