# docker-ruby-imagemagick

![Lint Status](https://github.com/mfinelli/docker-ruby-imagemagick/workflows/Lint/badge.svg)
![Image Size](https://img.shields.io/docker/image-size/mfinelli/ruby-imagemagick)

Debian still ships imagemagick6 in their repositories and I need imagemagick7
so this image is based on the `ruby:latest` with imagemagick7 compiled in.

```dockerfile
FROM mfinelli/ruby-imagemagick:latest
WORKDIR /app
RUN apt-get update && apt-get install -y firefox-esr
COPY Gemfile* package*.json /app/
RUN \
  bundle config set --local deployment true && \
  bundle config set --local path vendor/bundle && \
  bundle install && \
  npm ci
COPY . /app
RUN npm run build
CMD bundle exec rspec
```
