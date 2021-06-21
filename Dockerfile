FROM ruby:3.0.1

ENV BUNDLE_PATH /bundle

# Add Yarn repository
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && apt-get install -y \
  postgresql-client\
  vim \
  git \
  build-essential \
  curl \
  libffi-dev

RUN mkdir /application

WORKDIR /application

COPY Gemfile Gemfile.lock /application/

RUN mkdir -p /application/log && touch /application/log/development.log

RUN gem install bundler

RUN bundle install

COPY . /application
