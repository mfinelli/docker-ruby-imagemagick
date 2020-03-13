FROM ruby:latest

RUN \
  wget https://github.com/ImageMagick/ImageMagick/archive/7.0.10-0.tar.gz && \
  tar zxf 7.0.10-0.tar.gz && \
  cd ImageMagick-7.0.10-0 && \
  ./configure --prefix=/usr && \
  make && \
  make install && \
  cd ../ && \
  rm -rf ImageMagick-7.0.10-0 && \
  rm 7.0.10-0.tar.gz && \
  /usr/bin/magick --version

CMD ["irb"]
