FROM ruby:3.2.2

RUN apt-get update

RUN apt-get install -y g++ make libmariadb-dev tzdata

WORKDIR /app

COPY Gemfile .

RUN bundle install
