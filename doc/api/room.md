# Room

## index

get a list of online rooms

### Request

- HTTP Method: `GET`
- URL: `api/rooms`

### Response

```json
{
  "rooms": [
    {
      "id": 1166,
      "key": "0960",
      "online": true,
      "url": "https://danmu-classroom.herokuapp.com/api/rooms/0960"
    }
  ],
  "room_counts": 1,
  "url": "https://danmu-classroom.herokuapp.com/api/rooms"
}
```

## Show

get a online rooms

### Request

- HTTP Method: `GET`
- URL: `api/rooms/:key`

### Response

```json
{
  "id": 1166,
  "key": "0960",
  "online": true,
  "url": "https://danmu-classroom.herokuapp.com/api/rooms/0960"
}
```

## Create

Create a new room

### Request

- HTTP Method: `POST`
- URL: `api/rooms`

### Response

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

## Update

login user as room creater, after login, you can see previous danmus in this room.

### Request

- HTTP Method : `PATCH`
- URL : `api/rooms/:key`
- body :

```json
{
 "email": "example@gmail.com",
 "password": "password",
 "auth_token": "EhpofVP9yG4A9GbGMcRdxMZz"
}
```

### Response

response a json body :

```json
{
 "id": 287,
 "key": "6715",
 "online": true,
 "url": "http://localhost:3000/rooms/287"
}
```
