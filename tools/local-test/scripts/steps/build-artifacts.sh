TEMP_DB_PATH=$TMP_PATH/file-db
rm -rf $TEMP_DB_PATH/*

extensions=("smoke" "tests" "yaxunit")
configuration_exists=0

if [[ -f $BINARY_PATH/configuration.cf ]]; then
    configuration_exists=1
    echo "  Сборка конфигурации не требуется"
fi

extensions_set=()
for key in "${extensions[@]}";do
    if [[ -f $BINARY_PATH/$key.cfe ]]; then
        echo "  Сборка $key не требуется"
    else
        extensions_set+=($key)
    fi
done

if [[ ${#extensions_set[@]} -eq 0 && $configuration_exists  -eq 1 ]]; then
    exit 0
fi

echo "  Создание информационной базы"
$ONEC_PATH/ibcmd infobase create --db-path=$TEMP_DB_PATH --import=$EXPORT_PATH/configuration --apply --force

if [[ $configuration_exists -eq 0 ]]; then
    echo "  Сохрание тестовой конфигурации"
    $ONEC_PATH/ibcmd infobase config save --db-path=$TEMP_DB_PATH $BINARY_PATH/configuration.cf
fi

for key in "${extensions_set[@]}";do
    echo "  Импорт расширения $key"
    $ONEC_PATH/ibcmd infobase config import --db-path=$TEMP_DB_PATH --extension=$key $EXPORT_PATH/$key
    echo "  Сохрание расширения $key"
    $ONEC_PATH/ibcmd infobase config save --db-path=$TEMP_DB_PATH --extension=$key $BINARY_PATH/$key.cfe
done