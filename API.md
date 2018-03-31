API doc

# Room

Create a new room:
- Desc: Create a new room, return redis url and channel for subscribe.
- HTTP Method: `POST`
- URL: `/rooms`
- Example: `https://danmu-classroom.herokuapp.com/rooms`
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
