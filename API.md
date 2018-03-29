API doc

# Room

Create a new room:
- Desc: Get csrf token first.
- HTTP Method: `GET`
- URL: `/rooms/new`
- Example: `https://danmu-classroom.herokuapp.com/rooms/new`
- Return json example:
```json
{
  "create_room_url": "https://danmu-classroom.herokuapp.com/rooms",
  "create_room_action": "POST",
  "create_room_require_parameters": [
    "authenticity_token"
  ],
  "create_room_option_parameters": [],
  "authenticity_token": "token",
  "create_room_example": "POST: https://danmu-classroom.herokuapp.com/rooms?authenticity_token=token",
  "url": "https://danmu-classroom.herokuapp.com/rooms/new"
}
```


- Desc: Create a new room with csrf token.
- HTTP Method: `POST`
- URL: `/rooms`
- Example: `https://danmu-classroom.herokuapp.com/rooms?authenticity_token=token`
- Return json example:
```json
{
	"id": 7,
	"key": "4e45a3",
	"redis": "redis://password@host:port",
	"channel": "4e45a3_1522320425",
	"stream_ip": "140.117.247.174",
	"online": true,
	"creater_ip": "140.117.247.174",
	"created_at": "2018-03-29T10:47:05.026Z",
	"updated_at": "2018-03-29T10:47:05.026Z",
	"url": "https://danmu-classroom.herokuapp.com/rooms/7"
}
```
