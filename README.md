彈幕教室 伺服器端

# Tech Stack

Ruby 2.5
Rails 5.1.4
Postgres 10
Redis 4

# Deploy

部屬於 Heroku

## 多帳號切換外掛

切換 Heroku User 的外掛 <https://github.com/heroku/heroku-accounts>
記錄於 `~/.heroku/accounts`

# issue note

## `rails` 指令沒有反應

```bash
# no response
$ rails g -h
```

> <https://stackoverflow.com/questions/31857365/rails-generate-commands-hang-when-trying-to-create-a-model>

把 `spring` 停掉

    $ spring stop

在重試指令，就好了

```bash
# work
$ rails g -h
```

## figaro 環境變數設定

把 `config/application.yml` 的變數上傳至 Heroku

```bash
$ figaro heroku:set -e production
```
