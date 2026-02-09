#!/bin/bash
set -e

# Wait until the app is ready
sleep 10
/rails/bin/signal.sh wait

# Set SECRET_KEY_BASE
LOCATION_OF_SECRET_KEY_BASE_FILE="/rails/secrets/secret_key_base"
export SECRET_KEY_BASE=$(cat $LOCATION_OF_SECRET_KEY_BASE_FILE)

# Update the crontab with Whenever
/usr/local/bin/bundle exec whenever --update-crontab 

# Start the cron daemon in the foreground
cron -f -L 15