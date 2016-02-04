FROM ruby:1.9.3
RUN apt-get update -qq && apt-get install -y build-essential nodejs npm nodejs-legacy mysql-client vim
RUN npm install -g phantomjs

WORKDIR /tarantula
COPY Gemfile* /tarantula/

RUN bundle install

ADD . /tarantula
WORKDIR /tarantula
RUN RAILS_ENV=production bundle exec rake assets:precompile --trace
CMD ["rails","server","-b","0.0.0.0"]