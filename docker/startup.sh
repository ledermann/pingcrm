#! /bin/sh

echo "Starting ..."
echo "Git commit: $COMMIT_SHA - $COMMIT_TIME"
echo "----------------"

# Wait for PostgreSQL
until nc -z -v -w30 "$DB_HOST" 5432
do
  echo "Waiting for PostgreSQL on $DB_HOST:5432 ..."
  sleep 1
done
echo "PostgreSQL is up and running!"

# Create or migrate database
echo "Preparing database..."
bin/rails db:prepare
echo "Database is ready!"

exec "$@"
