show_auth_token ||= false
json.partial! 'room', room: @room, show_auth_token: show_auth_token
