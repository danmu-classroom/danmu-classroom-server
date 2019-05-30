show_auth_token ||= false
json.extract! room, :id, :key, :online
json.url api_room_url(room.key, format: :json)
json.extract!(room, :auth_token, :auth_token_sent_at) if show_auth_token == true
