# API doc

## Room

### Create:

-   Desc: Create a new room
-   HTTP Method: `POST`
-   URL: `api/rooms`
-   response body:

```json
{
	"id": 287,
	"key": "6715",
	"online": true,
	"url": "http://localhost:3000/rooms/287",
	"auth_token": "EhpofVP9yG4A9GbGMcRdxMZz",
	"auth_token_sent_at": "2018-11-11T15:21:20.231Z"
}
```

### Update

-   Desc: update room
-   HTTP Method: `PATCH`
-   URL: `api/rooms/:key`
-   request body:

```json
{
	"email": "example@gmail.com",
	"password": "password",
	"auth_token": "EhpofVP9yG4A9GbGMcRdxMZz"
}
```

-   response body:

```json
{
	"id": 287,
	"key": "6715",
	"online": true,
	"url": "http://localhost:3000/rooms/287"
}
```

## Danmu

### index

-   Desc: get new danmus
-   HTTP Method: `GET`
-   URL: `api/rooms/:key/danmus?auth_token=room_token`
-   response body:

```json
[
	{ "content": "彈幕 1 號", "created_at": "2019-05-29T04:41:58.859Z" },
	{ "content": "彈幕 2 號", "created_at": "2019-05-29T04:41:58.959Z" },
	{ "content": "彈幕 3 號", "created_at": "2019-05-29T04:41:58.999Z" },
]
```

### Create

-   Desc: create a danmu
-   HTTP Method: `POST`
-   URL: `api/rooms/:key/danmus`
-   request body:

```json
{
	"danmu":{
		"content": "messsage",
		"sender": {
			"provider": "line",
			"uid": "line-uid"
		}
	}
}
```

-   response body:

```json
{
	"id": 115,
	"content": "content",
	"room_id": 287,
	"sender_id": 6,
	"created_at": "2018-11-11T15:29:51.260Z",
	"updated_at": "2018-11-11T15:29:51.260Z"
}
```
