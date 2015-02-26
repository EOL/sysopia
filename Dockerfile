FROM ruby:2.1.5
MAINTAINER Dmitry Mozzherin

RUN apt-get install libmysqlclient-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN bundle config --global frozen 1
RUN mkdir -p /app
WORKDIR /app
COPY Gemfile /app/
COPY Gemfile.lock /app/
RUN bundle install --without development test
COPY . /app

#CMD ["SYSOPIA=./config/env.sh unicorn -c ./config/docker/unicorn.rb"]

