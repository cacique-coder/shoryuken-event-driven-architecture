FROM ruby:2.7.0

RUN mkdir app
WORKDIR /app

COPY . .
RUN bundle install

CMD ruby app.rb