#!/bin/bash

set -e

host="$1"
shift
cmd="$@"

>&2 echo -e "\e[93mPostgres is unavailable - waiting\e[39m"
until psql -h "$host" -U "postgres" -c '\q' &>/dev/null; do
  sleep 1
done

>&2 echo -e "\e[32mPostgres is up - executing command\e[39m"
exec $cmd