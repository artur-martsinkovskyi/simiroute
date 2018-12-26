FROM ruby:2.5.3

RUN apt-get update -qq \
      && apt-get install -y --no-install-recommends build-essential=12.3 libpq-dev=9.6.10-0+deb9u1 nodejs=4.8.2~dfsg-1 \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/

ENV INSTALL_PATH /simiroute
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH
COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock
RUN bundle install
COPY . ./

LABEL maintainer="Artur Marsinkovskyi <deimoss42@gmail.com>"
