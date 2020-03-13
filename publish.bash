#!/bin/bash -e

if [[ $# -ne 0 ]]; then
  echo >&2 "usage: $(basename "$0")"
  exit 1
fi

docker build -t mfinelli/ruby-imagemagick .
docker push mfinelli/ruby-imagemagick

exit 0
