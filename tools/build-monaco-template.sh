#!/bin/bash

CURRENT_PATH=$(pwd)
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
TARGET_DIR="$SCRIPTPATH/../exts/yaxunit/src/CommonTemplates/ЮТMonacoEditor"

if [ ! -f "${SCRIPTPATH}/.env" ]; then
    echo "Error: .env file not found in ${SCRIPTPATH}" >&2
    exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Target directory $TARGET_DIR does not exist" >&2
    exit 1
fi

. "${SCRIPTPATH}/.env"

if [ -z "$MONACO_EDITOR_PATH" ]; then
    echo "Error: MONACO_EDITOR_PATH is not set" >&2
    exit 1
fi

if [ ! -d "$MONACO_EDITOR_PATH/dist" ]; then
    echo "Error: Directory $MONACO_EDITOR_PATH/dist does not exist" >&2
    exit 1
fi

cd $MONACO_EDITOR_PATH/dist


zip -r -9 $SCRIPTPATH/monaco.zip ./
mv $SCRIPTPATH/monaco.zip $TARGET_DIR/Template.bin

echo "Обновлен макет $TARGET_DIR/Template.bin"
cd ${CURRENT_PATH}