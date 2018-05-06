API doc

# Room

Create a new room:
- Desc: Create a new room
- HTTP Method: `POST`
- URL: `/rooms`
- Example: `https://danmu-classroom.herokuapp.com/rooms?webhook=https://danmu.app/webhook`
- Return json example:
```json
{
	"id": 7,
	"key": "4e45a3",
	"webhook": "https://danmu.app/webhook",
	"stream_ip": "140.117.247.174",
	"online": true,
	"creater_ip": "140.117.247.174",
	"created_at": "2018-03-29T10:47:05.026Z",
	"updated_at": "2018-03-29T10:47:05.026Z",
	"url": "https://danmu-classroom.herokuapp.com/rooms/7"
}
```
