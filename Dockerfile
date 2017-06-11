FROM ruby:2.3.1

RUN apt-get update -qq 
RUN apt-get install -y build-essential libpq-dev nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get isntall -y postgresql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/oak-api
WORKDIR /usr/src/oak-api

ADD Gemfile /usr/src/oak-api/
ADD Gemfile.lock /usr/src/oak-api/
RUN bundle --system

ADD . /usr/src/oak-api

# Initialize log
RUN cat /dev/null > /usr/src/app/log/production.log
RUN chmod -R a+w /usr/src/app/log

EXPOSE 3000

ENV RAILS_ENV=production

ENTRYPOINT ["/bin/bash", "/oak-api/wait-for-postgres.sh", "db"]