#!/bin/bash
set -e

# Wait until the app is ready
sleep 10
/rails/bin/signal.sh wait

# Set SECRET_KEY_BASE
LOCATION_OF_SECRET_KEY_BASE_FILE="/rails/secrets/secret_key_base"
export SECRET_KEY_BASE=$(cat $LOCATION_OF_SECRET_KEY_BASE_FILE)

# Start the Rails server
/usr/local/bin/bundle exec puma -C config/puma.rb
