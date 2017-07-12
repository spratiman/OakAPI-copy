#!/usr/bin/env bash

set -e

cmd="$@"

# Wait for PostgreSQL
until psql -h "$OAK_DATABASE_HOST" -U "postgres" -c "\q" 2>&1; do
  echo -e "\e[93mWaiting for PostgreSQL...\e[39m"
  sleep 1
done

echo -e "\e[32mPostgres is up and running - executing command\e[39m"

# If a server was running, end it
if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

exec $cmd