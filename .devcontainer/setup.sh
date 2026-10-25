#!/usr/bin/env bash
# Runs once after the dev container is created.
set -euo pipefail
cd "$(dirname "$0")/.."

bundle check || bundle install
yarn install --frozen-lockfile

# Rails 5.2 has no db:prepare: migrate an existing DB, otherwise create + load schema + seed.
bin/rails db:migrate 2>/dev/null || bin/rails db:setup
