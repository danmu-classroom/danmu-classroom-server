json.extract! room,
              :id,
              :key,
              :redis,
              :channel,
              :stream_ip,
              :online,
              :creater_ip,
              :created_at,
              :updated_at
json.url room_url(room, format: :json)
