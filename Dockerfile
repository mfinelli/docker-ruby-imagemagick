FROM ruby:latest

ENV GECKODRIVER_VERSION 0.26.0
ENV NODEJS_VERSION 12.16.1
ENV IMAGEMAGICK_VERSION 7.0.10-4

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
  wget https://github.com/mozilla/geckodriver/releases/download/v$GECKODRIVER_VERSION/geckodriver-v$GECKODRIVER_VERSION-linux64.tar.gz && \
  tar zxf geckodriver-v$GECKODRIVER_VERSION-linux64.tar.gz && \
  chown root:root geckodriver && mv geckodriver /usr/bin/geckodriver && \
  rm geckodriver-v$GECKODRIVER_VERSION-linux64.tar.gz && \
  wget https://nodejs.org/dist/v$NODEJS_VERSION/node-v$NODEJS_VERSION-linux-x64.tar.xz && \
  tar Jxf node-v$NODEJS_VERSION-linux-x64.tar.xz -C /usr/local --strip-components 1 && \
  rm node-v$NODEJS_VERSION-linux-x64.tar.xz && \
  /usr/bin/magick --version && \
  /usr/local/bin/node --version && \
  /usr/bin/geckodriver --version

CMD ["irb"]
