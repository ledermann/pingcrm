FROM ledermann/rails-base-builder:3.1.2-alpine AS Builder

# Remove some files not needed in resulting image
RUN rm .browserslistrc package.json postcss.config.js tailwind.config.js vite.config.ts yarn.lock

FROM ledermann/rails-base-final:3.1.2-alpine
LABEL maintainer="georg@ledermann.dev"

# Add Alpine packages
RUN apk add --no-cache vips

# Workaround to trigger Builder's ONBUILDs to finish:
COPY --from=Builder /etc/alpine-release /tmp/dummy

USER app

# Script to be executed every time the container starts
ENTRYPOINT ["docker/startup.sh"]
