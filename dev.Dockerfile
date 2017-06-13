FROM ruby:2.3.1

RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev nodejs postgresql-client

ADD Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

ENV APP_HOME /oak-api
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME

EXPOSE 3000

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]
