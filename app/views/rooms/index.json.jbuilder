json.partial! 'common/flash'
json.rooms(@rooms.present? ? (json.array! @rooms, partial: 'room', as: :room) : [])
json.room_counts @rooms.size
json.partial! 'actions'
json.url rooms_url(format: :json)
