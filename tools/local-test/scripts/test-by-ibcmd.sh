source .env

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

WORK_PATH=/tmp/yaxunit-test
EDT_PATH=/opt/1C/1CE/components/1c-edt-$EDT_VERSION-x86_64
ONEC_PATH=/opt/1cv8/x86_64/$ONEC_VERSION
PROJECT_PATH=$SCRIPTPATH/../..
DB_PATH=$WORK_PATH/file-db
mkdir -p $WORK_PATH

# echo "Конвертация configuration"
# $EDT_PATH/1cedtcli -data $WORK_PATH/ws -timeout 300 -command export --configuration-files $WORK_PATH/configuration --project $PROJECT_PATH/fixtures/demo-configuration

# echo "Конвертация yaxunit"
# $EDT_PATH/1cedtcli -data $WORK_PATH/ws -timeout 300 -command export --configuration-files $WORK_PATH/yaxunit --project $PROJECT_PATH/exts/yaxunit

# echo "Конвертация smoke"
# $EDT_PATH/1cedtcli -data $WORK_PATH/ws -timeout 300 -command export --configuration-files $WORK_PATH/smoke --project $PROJECT_PATH/exts/smoke

# echo "Конвертация тесты"
# $EDT_PATH/1cedtcli -data $WORK_PATH/ws -timeout 300 -command export --configuration-files $WORK_PATH/tests --project $PROJECT_PATH/tests

rm -rf $DB_PATH
echo "=========== Создание информационной базы"
$ONEC_PATH/ibcmd infobase create --db-path=$DB_PATH --import=$WORK_PATH/configuration --apply --force

echo "=========== Импорт расширения Smoke"
$ONEC_PATH/ibcmd infobase config import --db-path=$DB_PATH --extension=Smoke $WORK_PATH/smoke
$ONEC_PATH/ibcmd infobase config apply --db-path=$DB_PATH --extension=Smoke --force

echo "=========== Импорт расширения tests"
$ONEC_PATH/ibcmd infobase config import --db-path=$DB_PATH --extension=tests $WORK_PATH/tests
$ONEC_PATH/ibcmd infobase config apply --db-path=$DB_PATH --extension=tests --force

echo "=========== Импорт расширения YAXUNIT"
$ONEC_PATH/ibcmd infobase config import --db-path=$DB_PATH --extension=YAXUNIT $WORK_PATH/yaxunit
$ONEC_PATH/ibcmd infobase config apply --db-path=$DB_PATH --extension=YAXUNIT --force

$ONEC_PATH/ibcmd infobase config extension update --db-path=$DB_PATH --name=Smoke --safe-mode=no --unsafe-action-protection=no
$ONEC_PATH/ibcmd infobase config extension update --db-path=$DB_PATH --name=tests --safe-mode=no --unsafe-action-protection=no
$ONEC_PATH/ibcmd infobase config extension update --db-path=$DB_PATH --name=YAXUNIT --safe-mode=no --unsafe-action-protection=no

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

$ONEC_PATH/ibsrv --db-path=$DB_PATH --daemon
IBSRV_PID=$!
echo "IBSRV PID=$IBSRV_PID"

$ONEC_PATH/1cv8c /WS "http://localhost:8314" /C"RunUnitTests=$WORK_PATH/yaxunit-config.json" /DisableStartupDialogs /DisableStartupMessages /DisableUnrecoverableErrorMessage
kill $IBSRV_PID