#! /bin/sh

echo "Preparing database..."
bundle exec rake db:prepare && echo "Database is ready!"
