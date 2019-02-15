#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

PI_HOSTNAME=pi-local
DEPLOY_DIR=rpi-remote

pushd "$(dirname "$0")/.."

COMMIT_ID=$(git rev-parse --short HEAD)
BUILD_ARTIFACT=build-${COMMIT_ID}.tar.gz

# build UI
frontend/node.sh /bin/bash -c "npm install && ./node_modules/gulp/bin/gulp.js dist"

# collect backend and frontend into one archive
rm -rf build/ && mkdir -p build/static
cp -r backend/* build/
cp -r frontend/dist/* build/static/
cp conf/etc/supervisor/conf.d/rpi-remote.conf build/
tar czf ${BUILD_ARTIFACT} build

# deploy and start on the PI
scp ${BUILD_ARTIFACT} ${PI_HOSTNAME}:pi-remote.tar.gz
ssh ${PI_HOSTNAME} "rm -rf ${DEPLOY_DIR} && mkdir ${DEPLOY_DIR} && tar xzf pi-remote.tar.gz --strip-components=1 -C ${DEPLOY_DIR} && rm pi-remote.tar.gz"
ssh ${PI_HOSTNAME} "sudo /bin/bash -c 'mv ${DEPLOY_DIR}/rpi-remote.conf /etc/supervisor/conf.d/ && /etc/init.d/supervisor restart'"

popd
