#!/bin/bash

CURRENT_PATH=$(pwd)
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cd ${SCRIPTPATH}/web-socket

yarn install && yarn build
cd dist

zip -r -9 ../web-socket.zip ./
mv ../web-socket.zip ../../../exts/yaxunit/src/CommonTemplates/ЮТWebSocket/Template.bin
cd ${CURRENT_PATH}