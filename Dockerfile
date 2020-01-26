FROM docker.pkg.github.com/ledermann/docker-rails-base/rails-base-builder:latest AS Builder
FROM docker.pkg.github.com/ledermann/docker-rails-base/rails-base-final:latest
LABEL maintainer="georg@ledermann.dev"

USER app

# Start up
CMD ["docker/startup.sh"]
