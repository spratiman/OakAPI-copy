#! /bin/bash

./docker/wait-for-services.sh
./docker/prepare-db.sh
bundle exec rails server -p 3000 -b 0.0.0.0
