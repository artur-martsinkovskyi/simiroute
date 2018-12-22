FROM ruby:2.5.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /simiroute
WORKDIR /simiroute
COPY Gemfile /simiroute/Gemfile
COPY Gemfile.lock /simiroute/Gemfile.lock
RUN bundle install --binstubs
COPY . /simiroute

LABEL maintainer="Artur Marsinkovskyi <artur.martsinkovskyi@perfectial.com"
