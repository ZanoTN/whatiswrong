#!/usr/bin/env bash
set -euo pipefail

APP_DIR=$(pwd)
LOG_FILE=$APP_DIR/deploy.log

echo ""
echo "===== Deploy started: $(date) =====" | tee -a $LOG_FILE

echo "Pulling latest code..." | tee -a $LOG_FILE
git pull origin main | tee -a $LOG_FILE

echo "Setting ENV variables..." | tee -a $LOG_FILE
export RAILS_ENV=production
export SECRET_KEY_BASE_DUMMY=1

echo "Installing gems..." | tee -a $LOG_FILE
bundle install --deployment --without development test | tee -a $LOG_FILE

echo "Running migrations..." | tee -a $LOG_FILE
bundle exec rails db:prepare | tee -a $LOG_FILE

echo "Precompiling assets..." | tee -a $LOG_FILE
bundle exec rails assets:precompile | tee -a $LOG_FILE

echo "Restarting Rails service..." | tee -a $LOG_FILE
sudo systemctl restart whatiswrong-rails.service | tee -a $LOG_FILE

echo "===== Deploy finished: $(date) =====" | tee -a $LOG_FILE
