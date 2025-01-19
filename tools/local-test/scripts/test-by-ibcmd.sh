#!/bin/bash

export SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

source $SCRIPTPATH/../.env

if [[ -z "${EDT_VERSION}" ]]; then
    >&2 echo 'Не установлена переменная $EDT_VERSION'
    exit 1
fi

if [[ -z "$ONEC_VERSION" ]]; then
    >&2 echo 'Не установлена переменная $ONEC_VERSION'
    exit 1
fi


export EDT_PATH=/opt/1C/1CE/components/1c-edt-$EDT_VERSION-x86_64
export ONEC_PATH=/opt/1cv8/x86_64/$ONEC_VERSION

if [[ ! -d "${EDT_PATH}" ]]; then
    >&2 echo "Не найдена инсталяция ${EDT_PATH}"
    exit 1
fi

if [[ ! -d "$ONEC_PATH" ]]; then
    >&2 echo "Не найдена инсталяция ${ONEC_PATH}"
    exit 1
fi

export WORK_PATH=$(realpath $SCRIPTPATH/../workpath)
export ROOT_PATH=$(realpath $SCRIPTPATH/../../../)
export STEPS_PATH=$(realpath $SCRIPTPATH/steps)
export LIB_PATH=$(realpath $SCRIPTPATH/lib)

export TMP_PATH=$WORK_PATH/tmp
export DB_PATH=$WORK_PATH/file-db
export EXPORT_PATH=$WORK_PATH/export
export BINARY_PATH=$WORK_PATH/binary
export RESULT_PATH=$WORK_PATH/result
export LOGS_PATH=$WORK_PATH/logs

. $LIB_PATH/print.sh

mkdir -p $LOGS_PATH
mkdir -p $DB_PATH
mkdir -p $EXPORT_PATH
mkdir -p $BINARY_PATH

mkdir -p $TMP_PATH
mkdir -p $RESULT_PATH

rm -rf "${TMP_PATH:?}/"*
rm -rf "${RESULT_PATH:?}/"*
rm -rf "${LOGS_PATH:?}/"*

cat >~/.1cv8/1C/1cv8/conf/conf.cfg <<EOL
DisableUnsafeActionProtection=.*
EOL

declare -A SOURCE_PATHS=( ["yaxunit"]="exts/yaxunit" ["smoke"]="exts/smoke" ["tests"]="tests" ["configuration"]="fixtures/demo-configuration")

echo "=========== Анализ исходников ==========="
for key in "${!SOURCE_PATHS[@]}"; do
    $STEPS_PATH/clean-outdated.sh $key ${SOURCE_PATHS[$key]}
done

echo "=========== Конвертация исходников ==========="
for key in "${!SOURCE_PATHS[@]}"; do
    $STEPS_PATH/convert-to-xml.sh $key ${SOURCE_PATHS[$key]}
done

rm -rf $DB_PATH

print_run "Создание информационной базы"
$ONEC_PATH/ibcmd infobase create --db-path=$DB_PATH --import=$WORK_PATH/export/configuration --apply --force
print_state "Создание информационной базы"

print_run "Импорт расширения Smoke"
$ONEC_PATH/ibcmd infobase config import --db-path=$DB_PATH --extension=Smoke $WORK_PATH/export/smoke
print_state "Импорт расширения Smoke"
$ONEC_PATH/ibcmd infobase config apply --db-path=$DB_PATH --extension=Smoke --force
print_state "Применение расширения Smoke"

print_run "Импорт расширения tests"
$ONEC_PATH/ibcmd infobase config import --db-path=$DB_PATH --extension=tests $WORK_PATH/export/tests
print_state "Импорт расширения tests"
$ONEC_PATH/ibcmd infobase config apply --db-path=$DB_PATH --extension=tests --force
print_state "Применение расширения tests"

print_run "Импорт расширения YAXUNIT"
$ONEC_PATH/ibcmd infobase config import --db-path=$DB_PATH --extension=YAXUNIT $WORK_PATH/export/yaxunit
print_state "Импорт расширения YAXUNIT"
$ONEC_PATH/ibcmd infobase config apply --db-path=$DB_PATH --extension=YAXUNIT --force
print_state "Применение расширения YAXUNIT"

$ONEC_PATH/ibcmd infobase config extension update --db-path=$DB_PATH --name=Smoke --safe-mode=no --unsafe-action-protection=no
print_state "Установка свойств расширения Smoke"
$ONEC_PATH/ibcmd infobase config extension update --db-path=$DB_PATH --name=tests --safe-mode=no --unsafe-action-protection=no
print_state "Установка свойств расширения tests"
$ONEC_PATH/ibcmd infobase config extension update --db-path=$DB_PATH --name=YAXUNIT --safe-mode=no --unsafe-action-protection=no
print_state "Установка свойств расширения YAXUNIT"

cat >$WORK_PATH/yaxunit-config.json <<EOL
{
    "reportFormat": "jUnit",
    "reportPath": "$WORK_PATH/report.xml",
    "closeAfterTests": true,
    "exitCode": "$WORK_PATH/exit-code.txt",
    "logging": {
        "console": true
    }
}
EOL

print_run "Запуск сервера"
$ONEC_PATH/ibsrv --db-path=$DB_PATH --daemon
IBSRV_PID=$!
echo "IBSRV PID=$IBSRV_PID"

print_run "Запуск тестирования"
$ONEC_PATH/1cv8c /WS "http://localhost:8314" /C"RunUnitTests=$WORK_PATH/yaxunit-config.json" /DisableStartupDialogs /DisableStartupMessages /DisableUnrecoverableErrorMessage
print_state "Тестирование"
kill $IBSRV_PID