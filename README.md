彈幕教室 伺服器端

# Tech Stack

Ruby 2.5.0
Rails 5.2.3
Postgres 10
Redis 4.1

# Deploy

部屬於 Heroku，環境變數 RAILS_MASTER_KEY 的值填入 `config/master.key` 內的金鑰。

編輯 credentials

```bash
$ EDITOR="atom --wait" rails credentials:edit
```
