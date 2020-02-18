FROM ledermann/rails-base-builder:latest AS Builder
FROM ledermann/rails-base-final:latest
LABEL maintainer="georg@ledermann.dev"

# Add Alpine packages
RUN apk add vips

USER app

# Start up
CMD ["docker/startup.sh"]
