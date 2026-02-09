#!/bin/bash
set -e

# Lock the signal to prevent the app from starting before the database is ready
/rails/bin/signal.sh lock

# Set SECRET_KEY_BASE
LOCATION_OF_SECRET_KEY_BASE_FILE="/rails/secrets/secret_key_base"

if [ -f "$LOCATION_OF_SECRET_KEY_BASE_FILE" ]; then
	export SECRET_KEY_BASE=$(cat $LOCATION_OF_SECRET_KEY_BASE_FILE)
else
	export SECRET_KEY_BASE=$(bundle exec rails secret)
	echo "$SECRET_KEY_BASE" > "$LOCATION_OF_SECRET_KEY_BASE_FILE"
fi

# Prepare the database and seed data
/usr/local/bin/bundle exec rails db:prepare
/usr/local/bin/bundle exec rails db:seed