#!/bin/sh
set -e

echo "Starting Chatwoot on Railway..."

# Remove stale pid file
rm -rf /app/tmp/pids/server.pid

# Wait for database
echo "Waiting for database..."
sleep 5

# Run migrations
echo "Running database migrations..."
bundle exec rails db:prepare || echo "Migration failed, continuing..."

# Load config
echo "Loading config..."
bundle exec rails runner "ConfigLoader.new.process" || echo "Config load failed, continuing..."

# Start server
echo "Starting Rails server on port ${PORT:-3000}..."
exec bundle exec rails server -b 0.0.0.0 -p ${PORT:-3000}
