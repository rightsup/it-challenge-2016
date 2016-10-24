FROM ruby:2.3-alpine
MAINTAINER RightsUp <it@rightsup.com>

RUN apk add --update alpine-sdk bash

# RUN locale-gen en_US.UTF-8
# ENV LANG en_US.UTF-8
# ENV LANGUAGE en_US:en
# ENV LC_ALL en_US.UTF-8

# RUN rbenv global 2.2.3

# Create app directory
RUN mkdir /app
WORKDIR /app

# Install gems
ADD Gemfile /app/
ADD Gemfile.lock /app/
RUN bundle install

# Set default environement
ENV RACK_ENV test

# Prepare the app
ADD . /app
