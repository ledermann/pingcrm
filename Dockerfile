FROM ledermann/rails-base-builder:3.0.1-alpine AS Builder

# Remove some files not needed in resulting image
RUN rm .browserslistrc babel.config.js package.json postcss.config.js yarn.lock

FROM ledermann/rails-base-final:3.0.1-alpine
LABEL maintainer="georg@ledermann.dev"

# Add Alpine packages
RUN apk add --no-cache vips

# Workaround to trigger Builder's ONBUILDs to finish:
COPY --from=Builder /etc/alpine-release /tmp/dummy

USER app

# Start up
CMD ["docker/startup.sh"]
