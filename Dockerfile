FROM ruby:2.5.3

USER root

RUN apt-get update -qq \
      && apt-get install -y --no-install-recommends \
      build-essential=12.3 libpq-dev=9.6.13-0+deb9u1 nodejs=4.8.2~dfsg-1 vim \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/

ENV APP_USER app
ENV APP_USER_HOME /home/$APP_USER
ENV APP_HOME /home/www/simiroute

RUN useradd -m -d $APP_USER_HOME $APP_USER

RUN mkdir /var/www && \
 chown -R $APP_USER:$APP_USER /var/www && \
 chown -R $APP_USER $APP_USER_HOME

WORKDIR $APP_HOME

USER $APP_USER

COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install
COPY . .

USER root

RUN chown -R $APP_USER:$APP_USER "$APP_HOME/."

USER $APP_USER

RUN bin/rails assets:precompile

CMD bundle exec puma -C config/puma.rb
