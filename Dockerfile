# Base image:
FROM ruby:2.4.1

# Install dependencies
RUN apt-get update -yqq && apt-get --no-install-recommends install -yqq build-essential libpq-dev nodejs

# Set an environment variable where the Rails app is installed to inside of Docker image:
ENV RAILS_ROOT=/var/www/customer_support_portal
ENV RAILS_ENV=production
RUN mkdir -p $RAILS_ROOT

# Set working directory, where the commands will be ran:
WORKDIR $RAILS_ROOT

# Gems:
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler
RUN bundle check || bundle install --without development test -j4

COPY config/puma.rb config/puma.rb

# Copy the main application.
COPY . .

RUN exec rails assets:precompile RAILS_ENV=production
RUN exec rails db:create
RUN exec rails db:migrate

EXPOSE 3000

# The default command that gets run will be to start the Puma server.
CMD bundle exec puma -C config/puma.rb
