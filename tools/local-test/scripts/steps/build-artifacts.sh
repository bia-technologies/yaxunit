TEMP_DB_PATH=$TMP_PATH/file-db
. $LIB_PATH/print.sh

rm -rf $TEMP_DB_PATH/*

extensions=("smoke" "tests" "yaxunit")
configuration_exists=0

if [[ -f $BINARY_PATH/configuration.cf ]]; then
    configuration_exists=1
    print_success "  Сборка конфигурации ${BOLD}не требуется${RESET}"
fi

extensions_set=()
for key in "${extensions[@]}";do
    if [[ -f $BINARY_PATH/$key.cfe ]]; then
        print_success "  Сборка $key ${BOLD}не требуется${RESET}"
    else
        extensions_set+=($key)
    fi
done

if [[ ${#extensions_set[@]} -eq 0 && $configuration_exists  -eq 1 ]]; then
    exit 0
fi

print_run "Сборка артефактов"

$ONEC_PATH/ibcmd infobase create --db-path=$TEMP_DB_PATH --import=$EXPORT_PATH/configuration --apply --force >> $LOGS_PATH/configuration.log 2>&1
print_state 'Создание информационной базы'

if [[ $configuration_exists -eq 0 ]]; then
    $ONEC_PATH/ibcmd infobase config save --db-path=$TEMP_DB_PATH $BINARY_PATH/configuration.cf >> $LOGS_PATH/configuration.log 2>&1
    print_state 'Сохрание тестовой конфигурации'
fi

for key in "${extensions_set[@]}";do
    $ONEC_PATH/ibcmd infobase config import --db-path=$TEMP_DB_PATH --extension=$key $EXPORT_PATH/$key >> $LOGS_PATH/$key.log 2>&1
    print_state "Импорт расширения ${BOLD}$key${RESET}"
    
    $ONEC_PATH/ibcmd infobase config save --db-path=$TEMP_DB_PATH --extension=$key $BINARY_PATH/$key.cfe >> $LOGS_PATH/$key.log 2>&1
    print_state "Сохрание расширения ${BOLD}$key${RESET}"
done