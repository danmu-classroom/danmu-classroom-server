json.actions do
  json.rooms_online_url rooms_url(online: true, format: :json)
  json.new_room_url new_room_url
end
