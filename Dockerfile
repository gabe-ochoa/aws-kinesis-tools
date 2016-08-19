FROM ruby:2.3.1-alpine

# Add backup alpine package mirrors
RUN echo "http://dl-2.alpinelinux.org/alpine/v3.3/community" >> /etc/apk/repositories; \
    echo "http://dl-3.alpinelinux.org/alpine/v3.3/community" >> /etc/apk/repositories; \
    echo "http://dl-4.alpinelinux.org/alpine/v3.3/community" >> /etc/apk/repositories; \
    echo "http://dl-5.alpinelinux.org/alpine/v3.3/community" >> /etc/apk/repositories

RUN apk --update add bash git

RUN mkdir /usr/app
WORKDIR /usr/app

COPY Gemfile /usr/app/
COPY Gemfile.lock /usr/app/
RUN gem install bundler
RUN bundle install

COPY . /usr/app
