#!/bin/bash

pushd "$(dirname "$0")"

docker run \
    --user node \
    --rm -it \
    -v `pwd`:/home/node/src \
    -p 3000:3000 \
    -w /home/node/src \
    node:lts \
    "$@"

popd
