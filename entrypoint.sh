#!/bin/bash

set -e
rm -f /app/tmp/pids/server.pid
[ "$RAILS_ENV" = "development" ] && rm -rf config/credentials.yml.enc || /app/bin/rails credentials:edit
(bundle check || bundle install && bundle exec rails db:migrate)

exec "$@"
