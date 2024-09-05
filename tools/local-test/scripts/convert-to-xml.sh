rm -rf $EXPORT_PATH/*

echo "Конвертация configuration"
$EDT_PATH/1cedtcli -data $TMP_PATH/ws -timeout 300 -command export --configuration-files $EXPORT_PATH/configuration --project $ROOT_PATH/fixtures/demo-configuration

echo "Конвертация yaxunit"
$EDT_PATH/1cedtcli -data $TMP_PATH/ws -timeout 300 -command export --configuration-files $EXPORT_PATH/yaxunit --project $ROOT_PATH/exts/yaxunit

echo "Конвертация smoke"
$EDT_PATH/1cedtcli -data $TMP_PATH/ws -timeout 300 -command export --configuration-files $EXPORT_PATH/smoke --project $ROOT_PATH/exts/smoke

echo "Конвертация тесты"
$EDT_PATH/1cedtcli -data $TMP_PATH/ws -timeout 300 -command export --configuration-files $EXPORT_PATH/tests --project $ROOT_PATH/tests
