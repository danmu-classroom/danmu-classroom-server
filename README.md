# Danmu

## Tech Stack

- Ruby 2.7.1
- Rails 5.2.3
- PostgreSQL 12
- Redis 4.2
- Pusher

## Deploy

部屬於 Heroku，環境變數 RAILS_MASTER_KEY 的值填入 `config/master.key` 內的金鑰。

編輯 credentials

```bash
EDITOR="code --wait" rails credentials:edit
```

## API

You can send a http request to <https://danmu-classroom.herokuapp.com/>

Check out our RESTful api in `doc/api/*.md`
