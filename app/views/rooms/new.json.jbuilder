json.create_room_url rooms_url
json.create_room_action :POST
json.create_room_require_parameters ['authenticity_token']
json.create_room_option_parameters []
json.authenticity_token(token = form_authenticity_token)
json.create_room_example "POST: #{rooms_url(authenticity_token: token)}"
json.url new_room_url
