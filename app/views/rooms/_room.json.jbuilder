json.extract! room,
              :id,
              :key,
              :online,
              :webhook,
              :stream_ip,
              :creater_ip,
              :auth_token,
              :auth_token_sent_at,
              :created_at,
              :updated_at
json.url room_url(room, format: :json)
