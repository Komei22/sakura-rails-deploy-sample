FROM ruby:3.0.2

ENV APP_ROOT=/src

RUN set -ex

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq  \
    && apt-get install -y nodejs yarn
RUN mkdir ${APP_ROOT}

WORKDIR ${APP_ROOT}
ADD ./Gemfile ${APP_ROOT}/Gemfile
ADD ./Gemfile.lock ${APP_ROOT}/Gemfile.lock
RUN bundle install -j4
