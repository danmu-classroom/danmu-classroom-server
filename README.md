# Danmu

## Tech Stack

- Ruby 4.0
- Rails 8.1 (Propshaft, importmap, Turbo, Stimulus)
- Bootstrap 5 (cssbundling-rails + Dart Sass)
- PostgreSQL 18
- Redis 8
- LINE Messaging API (line-bot-api v2)

## Development

用 VS Code 開啟專案後選「Reopen in Container」（需要 Docker，例如 OrbStack）。
Dev Container 會一併啟動 PostgreSQL 與 Redis，並自動執行 `bundle install`、`yarn install`、`bin/rails db:prepare`。

```bash
bin/dev        # Rails server + CSS watcher，從 host 開 http://localhost:3001
bin/rails test # 測試
bin/rubocop    # Lint
bin/brakeman   # 安全性檢查
```

沒有 `config/master.key` 也能在本機開發與測試，只有 LINE bot webhook 需要 credentials 內的 channel secret / token。

## Deploy

部屬於 Heroku，環境變數 RAILS_MASTER_KEY 的值填入 `config/master.key` 內的金鑰。
Heroku 需要 Node.js（`yarn build:css` 會在 `assets:precompile` 時執行），Ruby buildpack 偵測到 `yarn.lock` 會自動安裝。

編輯 credentials

```bash
EDITOR="code --wait" rails credentials:edit
```

## API

You can send a http request to <https://danmu-classroom.herokuapp.com/>

Check out our RESTful api in `doc/api/*.md`
