# index

for danmu-classroom-screen to get new danmus

- HTTP Method: `GET`
- URL: `api/rooms/:key/danmus?auth_token=:room_token`

## Response

```json
[
 { "content": "彈幕 1 號", "created_at": "2019-05-29T04:41:58.859Z" },
 { "content": "彈幕 2 號", "created_at": "2019-05-29T04:41:58.959Z" },
 { "content": "彈幕 3 號", "created_at": "2019-05-29T04:41:58.999Z" },
]
```

# Create

for user to send a danmu into room

- HTTP Method: `POST`
- URL: `api/rooms/:key/danmus`

## Request

```json
{
 "danmu":{
  "content": ":messsage",
  "sender": {
   "provider": "line",
   "uid": ":line_uid"
  }
 }
}
```

## Response

```json
{
 "id": 115,
 "content": ":messsage",
 "room_id": 287,
 "sender_id": 6,
 "created_at": "2018-11-11T15:29:51.260Z",
 "updated_at": "2018-11-11T15:29:51.260Z"
}
```
