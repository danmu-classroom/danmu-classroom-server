class Sender < ApplicationRecord
  has_many :danmus, dependent: :destroy

  def last_action
    $redis.get "sender_#{id}_last_action"
  end

  def last_action=(action)
    $redis.set "sender_#{id}_last_action", action.to_s
  end

  def room_key
    $redis.get "sender_#{id}_room_key"
  end

  def room_key=(key)
    $redis.set "sender_#{id}_room_key", key.to_s
    self.last_action = 'set_room_key'
  end

  def send_danmu(text)
    room = Room.find_by!(key: room_key)
    danmus.create!(room: room, content: text)
    self.last_action = 'danmu'
    true
  rescue StandardError
    false
  end

  def delete_room_key
    $redis.del "sender_#{id}_room_key"
    self.last_action = 'delete_room_key'
  end
end
