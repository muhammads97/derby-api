# syntax=docker/dockerfile:1
FROM ruby:2.7.2

RUN apt-get update -qq && apt-get install -y apt-utils build-essential libssl-dev nodejs libpq-dev less vim nano libsasl2-dev ruby-dev zlib1g-dev

ENV WORK_ROOT /src
RUN mkdir $WORK_ROOT
ENV APP_HOME $WORK_ROOT/app/
ENV LANG C.UTF-8
ENV GEM_HOME $WORK_ROOT/bundle
ENV BUNDLE_BIN $GEM_HOME/gems/bin
ENV PATH $GEM_HOME/bin:$BUNDLE_BIN:$PATH


RUN gem install bundler
RUN mkdir -p $APP_HOME
RUN bundle config --path=$GEM_HOME

WORKDIR $APP_HOME

ADD Gemfile ./
ADD Gemfile.lock ./
RUN bundle install 

ADD . $APP_HOME


EXPOSE 3000

# ENTRYPOINT bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -b 0.0.0.0 -p 3000"

ENTRYPOINT [ "/src/app/entrypoint.sh" ]

CMD [ "rails", "server", "-b", "0.0.0.0" ]