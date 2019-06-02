# This is from a work project and this article

# To setup docker on your mac
# get docker desktop https://www.docker.com/products/docker-desktop
# docker build . -t kubernetes-test-container
# docker run -it -p 3000:3000 --rm kubernetes-test-container
# go to http://localhost:3000
# go to http://localhost:3000/users
# both should be working

FROM ruby:2.2.9-alpine

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash git openssh \
    && apk --update add build-base nodejs tzdata postgresql-dev postgresql-client make curl-dev \
    && apk add --no-cache --virtual imagemagick \
    && apk add --no-cache imagemagick-dev

RUN mkdir /myapp
WORKDIR /myapp

ADD Gemfile ./Gemfile
ADD Gemfile.lock ./Gemfile.lock
RUN bundle install

ADD . .

EXPOSE 3000
EXPOSE 80

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
