FROM ruby:2.3.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /oak-api
WORKDIR /oak-api
ADD Gemfile /oak-api/Gemfile
ADD Gemfile.lock /oak-api/Gemfile.lock
RUN bundle install
ADD . /oak-api
