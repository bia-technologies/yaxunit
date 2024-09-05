TEMP_DB_PATH=$TMP_PATH/file-db
rm -rf $TEMP_DB_PATH/*
rm -rf $$BINARY_PATH/*

echo "=========== Создание информационной базы"
$ONEC_PATH/ibcmd infobase create --db-path=$TEMP_DB_PATH --import=$EXPORT_PATH/configuration --apply --force

echo "=========== Импорт расширения Smoke"
$ONEC_PATH/ibcmd infobase config import --db-path=$TEMP_DB_PATH --extension=Smoke $EXPORT_PATH/smoke

echo "=========== Импорт расширения tests"
$ONEC_PATH/ibcmd infobase config import --db-path=$TEMP_DB_PATH --extension=tests $EXPORT_PATH/tests

echo "=========== Импорт расширения YAXUNIT"
$ONEC_PATH/ibcmd infobase config import --db-path=$TEMP_DB_PATH --extension=YAXUNIT $EXPORT_PATH/yaxunit

echo "=========== Сохрание тестовой конфигурации"
$ONEC_PATH/ibcmd infobase config save --db-path=$TEMP_DB_PATH $BINARY_PATH/configuration.cf

echo "=========== Сохрание расширения YAxUnit"
$ONEC_PATH/ibcmd infobase config save --db-path=$TEMP_DB_PATH --extension=YAXUNIT $BINARY_PATH/yaxunit.cfe

echo "=========== Сохрание расширения с тестами"
$ONEC_PATH/ibcmd infobase config save --db-path=$TEMP_DB_PATH --extension=tests $BINARY_PATH/tests.cfe

echo "=========== Сохрание расширения с дымовыми тестами"
$ONEC_PATH/ibcmd infobase config save --db-path=$TEMP_DB_PATH --extension=Smoke $BINARY_PATH/smoke.cfe
