#!/bin/bash

export SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

source $SCRIPTPATH/../.env

export EDT_PATH=/opt/1C/1CE/components/1c-edt-$EDT_VERSION-x86_64
export ONEC_PATH=/opt/1cv8/x86_64/$ONEC_VERSION

export WORK_PATH=$(realpath $SCRIPTPATH/../workpath)
export ROOT_PATH=$(realpath $SCRIPTPATH/../../../)
export STEPS_PATH=$(realpath $SCRIPTPATH/steps)
export LIB_PATH=$(realpath $SCRIPTPATH/lib)

export TMP_PATH=$WORK_PATH/tmp
export DB_PATH=$WORK_PATH/file-db
export EXPORT_PATH=$WORK_PATH/export
export BINARY_PATH=$WORK_PATH/binary
export RESULT_PATH=$WORK_PATH/result

mkdir -p $DB_PATH
mkdir -p $EXPORT_PATH
mkdir -p $BINARY_PATH

mkdir -p $TMP_PATH
mkdir -p $RESULT_PATH

rm -rf $TMP_PATH/*
rm -rf $RESULT_PATH/*

cat >~/.1cv8/1C/1cv8/conf/conf.cfg <<EOL
DisableUnsafeActionProtection=.*
EOL

declare -A SOURCES_HASH
declare -A SOURCE_PATHS=( ["yaxunit"]="exts/yaxunit" ["smoke"]="exts/smoke" ["tests"]="tests" ["configuration"]="fixtures/demo-configuration")
declare projects=()

echo "=========== Анализ исходников ==========="
for key in "${!SOURCE_PATHS[@]}"; do
    $STEPS_PATH/clean-outdated.sh $key ${SOURCE_PATHS[$key]}
done

echo "=========== Конвертация исходников ==========="
for key in "${!SOURCE_PATHS[@]}"; do
    $STEPS_PATH/convert-to-xml.sh $key ${SOURCE_PATHS[$key]}
done

echo "=========== Сборка исходников ==========="
if ! $STEPS_PATH/build-artifacts.sh; then
    exit 1
fi

echo "=========== Запуск сервера 1с в Docker ==========="
docker compose -f $SCRIPTPATH/../onec-server/docker-compose.yml up -d --force-recreate --renew-anon-volumes

echo "=========== Запуск тестирования ==========="
$STEPS_PATH/run-filedb-test.sh Ordinary &
$STEPS_PATH/run-filedb-test.sh Thick &
$STEPS_PATH/run-filedb-test.sh Thin &
$STEPS_PATH/run-serverdb-test.sh Ordinary &
$STEPS_PATH/run-serverdb-test.sh Thick &
$STEPS_PATH/run-serverdb-test.sh Thin &

wait