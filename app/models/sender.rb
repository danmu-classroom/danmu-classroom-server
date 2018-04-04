class Sender < ApplicationRecord
  has_many :danmus

  def last_action
    $redis.get "#{id}_last_action"
  end

  def last_action=(action)
    $redis.set "#{id}_last_action", action.to_s
  end

  def room_key
    $redis.get "#{id}_room_key"
  end

  def room_key=(key)
    $redis.set "#{id}_room_key", key.to_s
    self.last_action = 'set_room_key'
  end

  def send_danmu(text)
    room = Room.find_by!(key: room_key)
    danmu.create!(room: room, content: text)
    self.last_action = 'danmu'
  end
end
