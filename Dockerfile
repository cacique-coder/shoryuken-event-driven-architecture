FROM ruby:2.7.0

WORKDIR /app

COPY . .
RUN bundle install

CMD ruby api.rb