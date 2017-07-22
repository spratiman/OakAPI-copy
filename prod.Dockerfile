FROM ruby:2.3.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client && rm -rf /var/lib/apt/lists/*

ADD Gemfile* /tmp/
WORKDIR /tmp
RUN gem install bundler && bundle install --jobs 20 --retry 5 --without development test

# Set Rails to run in production
ENV RAILS_ENV production 
ENV RACK_ENV production

ENV APP_HOME /oak-api
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY . $APP_HOME

RUN ["chmod", "+x", "./bin/docker-entrypoint"]
ENTRYPOINT ["./bin/docker-entrypoint"]
