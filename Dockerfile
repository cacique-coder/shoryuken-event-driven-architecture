FROM ruby:2.7.0

RUN mkdir test
WORKDIR /test

COPY . .
RUN bundle install

CMD ruby api.rb