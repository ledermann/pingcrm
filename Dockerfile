######################
# Stage: Builder
FROM ruby:2.7.0-alpine as Builder

RUN apk add --update --no-cache \
  build-base \
  postgresql-dev \
  git \
  nodejs \
  yarn \
  tzdata

WORKDIR /app

ENV BUNDLE_WITHOUT=development:test
ENV RAILS_ENV=production
ENV SECRET_KEY_BASE=just-for-assets-compiling

# Install gems
ADD Gemfile* /app/
RUN bundle config --global frozen 1 && \
  bundle install -j4 --retry 3 && \
  # Remove unneeded files (cached *.gem, *.o, *.c)
  rm -rf /usr/local/bundle/cache/*.gem && \
  find /usr/local/bundle/gems/ -name "*.c" -delete && \
  find /usr/local/bundle/gems/ -name "*.o" -delete

# Install yarn packages
COPY package.json yarn.lock /app/
RUN yarn install

# Add the Rails app
ADD . /app

# Compile assets
RUN bundle exec rails webpacker:compile

# Remove folders not needed in resulting image
RUN rm -rf node_modules tmp/cache vendor/bundle test

###############################
# Stage Final
FROM ruby:2.7.0-alpine
LABEL maintainer="georg@ledermann.dev"

ARG COMMIT_SHA
ARG COMMIT_TIME

ENV COMMIT_SHA=${COMMIT_SHA} \
  COMMIT_TIME=${COMMIT_TIME} \
  RAILS_LOG_TO_STDOUT=true \
  RAILS_SERVE_STATIC_FILES=true

# Add Alpine packages
RUN apk add --update --no-cache \
  postgresql-client \
  vips \
  tzdata \
  file

# Add user
RUN addgroup -g 1000 -S app && \
  adduser -u 1000 -S app -G app
USER app

# Copy app with gems from former build stage
COPY --from=Builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=Builder --chown=app:app /app /app

WORKDIR /app

# Expose Puma port
EXPOSE 3000

# Start up
CMD ["docker/startup.sh"]
