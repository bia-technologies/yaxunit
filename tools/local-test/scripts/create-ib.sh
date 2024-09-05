CONNECTION_STRING=$1
JOB_NAME=$2

BASE_ARGUMENTS="$CONNECTION_STRING /DisableStartupDialogs /DisableStartupMessages"
DESIGNER_COMMAND="$ONEC_PATH/1cv8 DESIGNER $BASE_ARGUMENTS"

echo "=========== Создание информационной базы ($JOB_NAME)"
$ONEC_PATH/1cv8 CREATEINFOBASE File=$TEMP_DB_PATH

echo "=========== Загрузка конфигурации ($JOB_NAME)"
$DESIGNER_COMMAND /LoadCfg $BINARY_PATH/configuration.cf /UpdateDBCfg

echo "=========== Загрузка расширения YAXUNIT ($JOB_NAME)"
$DESIGNER_COMMAND /LoadCfg $BINARY_PATH/yaxunit.cfe -Extension YAXUNIT /UpdateDBCfg

echo "=========== Загрузка расширения tests ($JOB_NAME)"
$DESIGNER_COMMAND /LoadCfg $BINARY_PATH/tests.cfe -Extension tests /UpdateDBCfg

echo "=========== Загрузка расширения Smoke ($JOB_NAME)"
$DESIGNER_COMMAND /LoadCfg $BINARY_PATH/smoke.cfe -Extension Smoke /UpdateDBCfg

echo "=========== Снятие безопасного режима ($JOB_NAME)"
$ONEC_PATH/1cv8 ENTERPRISE $BASE_ARGUMENTS /Execute $SCRIPTPATH/DisableSafeMode.epf
