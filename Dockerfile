FROM ruby:2.7.2

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install -qq -y build-essential libpq-dev imagemagick nodejs yarn mupdf-tools

RUN mkdir /gifts-api-test-main
RUN gem update --system
RUN gem install bundler
WORKDIR /gifts-api-test-main
COPY Gemfile /gifts-api-test-main/Gemfile
COPY Gemfile.lock /gifts-api-test-main/Gemfile.lock

RUN bundle install
COPY . /gifts-api-test-main

EXPOSE 3000

