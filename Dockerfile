FROM ghcr.io/ledermann/rails-base-builder:3.4.1-alpine AS builder

# Remove some files not needed in resulting image
RUN rm .browserslistrc package.json postcss.config.js vite.config.mts

FROM ghcr.io/ledermann/rails-base-final:3.4.1-alpine
LABEL maintainer="georg@ledermann.dev"

# Add Alpine packages
RUN apk add --no-cache vips

USER app

# Entrypoint prepares the database.
ENTRYPOINT ["docker/startup.sh"]

# Start the server by default, this can be overwritten at runtime
CMD ["./bin/rails", "server"]
