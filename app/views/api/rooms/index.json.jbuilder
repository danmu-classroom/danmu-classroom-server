json.partial! 'common/flash'
json.rooms @rooms do |room|
  json.partial! 'room', room: room
end
json.room_counts @rooms.size
json.url api_rooms_url(format: :json)
