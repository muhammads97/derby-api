#!/bin/bash

set -xe;

bundle install

rm -rf /app/tmp/pids/server.pid;

rails db:create db:migrate

echo '[+] starting up...'

exec "$@"
