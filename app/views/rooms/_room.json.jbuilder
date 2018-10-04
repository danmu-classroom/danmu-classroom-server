show_auth_token ||= false
json.extract! room, :id, :key, :online, :webhook
json.url room_url(room, format: :json)
json.extract!(room, :auth_token, :auth_token_sent_at) if show_auth_token == true
