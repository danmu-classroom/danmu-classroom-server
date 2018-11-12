API doc

# Room

## Create:

-   Desc: Create a new room
-   HTTP Method: `POST`
-   URL: `/rooms`
-   request body:

```json
{
	"room":{
		"webhook": "https://bd277df2.ngrok.io"
	}
}
```

-   response body:

```json
{
	"id": 287,
	"key": "6715",
	"online": true,
	"webhook": "https://bd277df2.ngrok.io",
	"url": "http://localhost:3000/rooms/287",
	"auth_token": "EhpofVP9yG4A9GbGMcRdxMZz",
	"auth_token_sent_at": "2018-11-11T15:21:20.231Z"
}
```

## Update

-   Desc: update room
-   HTTP Method: `PATCH`
-   URL: `/rooms/:key`
-   request body:

```json
{
	"room":{
		"webhook": "https://bd277df2222323.ngrok.io"
	},
	"auth_token": "EhpofVP9yG4A9GbGMcRdxMZz"
}
```

-   response body:

```json
{
	"id": 287,
	"key": "6715",
	"online": true,
	"webhook": "https://bd277df2222323.ngrok.io",
	"url": "http://localhost:3000/rooms/287"
}
```

# Danmu

## Create

-   Desc: create a danmu
-   HTTP Method: `POST`
-   URL: `/rooms/:key/danmus`
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
