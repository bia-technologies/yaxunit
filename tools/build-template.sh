#!/bin/bash

CURRENT_PATH=$(pwd)
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cd ${SCRIPTPATH}/v8unpack
ls -lna
zip -r -9 ../v8unpack.zip ./
mv ../v8unpack.zip ../../exts/yaxunit/src/CommonTemplates/ЮТV8UnpackLinux/Template.bin
cd ${CURRENT_PATH}