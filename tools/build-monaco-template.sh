#!/bin/bash

CURRENT_PATH=$(pwd)
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

. "${SCRIPTPATH}/.env"

cd $MONACO_EDITOR_PATH/dist

zip -r -9 $SCRIPTPATH/monaco.zip ./
mv $SCRIPTPATH/monaco.zip $SCRIPTPATH/../exts/yaxunit/src/CommonTemplates/ЮТMonacoEditor/Template.bin
cd ${CURRENT_PATH}