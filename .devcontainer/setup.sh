#!/usr/bin/env bash
# Runs once after the dev container is created.
set -euo pipefail
cd "$(dirname "$0")/.."

export COREPACK_ENABLE_DOWNLOAD_PROMPT=0
bundle check || bundle install
yarn install --frozen-lockfile
yarn build:css
bin/rails db:prepare
