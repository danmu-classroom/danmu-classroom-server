class Danmu < ApplicationRecord
  belongs_to :room
  belongs_to :sender

  validate do
    errors.add(:base, 'Room is offline, can not add new danmu.') unless room.online?
  end

  after_create do
    send_to(room.webhook)
  end

  def to_h
    h = {
      content: content
    }
  end

  def send_to(url)
    res = HTTP.post(url, json: to_h).body.to_s
    puts res
    Rails.logger.debug { "send danmu : #{url} : #{to_h.to_json}" }
  end
end
