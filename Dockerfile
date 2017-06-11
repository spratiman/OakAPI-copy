FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client

RUN mkdir /oak-api
WORKDIR /oak-api

ADD Gemfile /oak-api/Gemfile
ADD Gemfile.lock /oak-api/Gemfile.lock
RUN bundle install

ADD . /oak-api

EXPOSE 80

ENTRYPOINT ["/bin/bash", "/oak-api/wait-for-postgres.sh", "db"]
CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]