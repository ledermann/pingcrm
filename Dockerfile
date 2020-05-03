FROM ledermann/rails-base-builder:latest AS Builder

# Remove some files not needed in resulting image
RUN rm .browserslistrc babel.config.js package.json postcss.config.js yarn.lock

FROM ledermann/rails-base-final:latest
LABEL maintainer="georg@ledermann.dev"

# Add Alpine packages
RUN apk add --no-cache vips

USER app

# Start up
CMD ["docker/startup.sh"]
