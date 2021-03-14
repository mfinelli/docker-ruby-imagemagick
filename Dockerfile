FROM rust:slim as builder
WORKDIR /geckodriver

ARG GECKODRIVER_VERSION=0.29.0
ENV GECKODRIVER_VERSION=$GECKODRIVER_VERSION

RUN apt-get update && apt-get install -y curl
RUN \
  curl -LO https://github.com/mozilla/geckodriver/archive/v${GECKODRIVER_VERSION}.tar.gz && \
  tar zxf v${GECKODRIVER_VERSION}.tar.gz --strip-components=1 && \
  cargo build --release && \
  ./target/release/geckodriver --version

FROM ruby:2.7

ARG NODEJS_VERSION=14.16.0
ENV NODEJS_VERSION=$NODEJS_VERSION
ARG IMAGEMAGICK_VERSION=7.0.11-3
ENV IMAGEMAGICK_VERSION=$IMAGEMAGICK_VERSION

COPY --from=builder /geckodriver/target/release/geckodriver /usr/local/bin
RUN \
  wget https://github.com/ImageMagick/ImageMagick/archive/${IMAGEMAGICK_VERSION}.tar.gz && \
  tar zxf ${IMAGEMAGICK_VERSION}.tar.gz && \
  cd ImageMagick-${IMAGEMAGICK_VERSION} && \
  ./configure --prefix=/usr && \
  make && \
  make install && \
  cd ../ && \
  rm -rf ImageMagick-${IMAGEMAGICK_VERSION} && \
  rm ${IMAGEMAGICK_VERSION}.tar.gz && \
  wget https://nodejs.org/dist/v$NODEJS_VERSION/node-v$NODEJS_VERSION-linux-x64.tar.xz && \
  tar Jxf node-v$NODEJS_VERSION-linux-x64.tar.xz -C /usr/local --strip-components 1 && \
  rm node-v$NODEJS_VERSION-linux-x64.tar.xz && \
  /usr/bin/magick --version && \
  /usr/local/bin/node --version && \
  /usr/local/bin/geckodriver --version

CMD ["irb"]
