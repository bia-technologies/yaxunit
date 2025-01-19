PROJECT_NAME=$1
PROJECT_PATH=$2

. $LIB_PATH/print.sh

if [[ -d $EXPORT_PATH/$PROJECT_NAME ]]; then
    print_info "Конвертация ${BOLD}$PROJECT_NAME${RESET} не требуется"
else
    print_run "Конвертация ${BOLD}$PROJECT_NAME${RESET}"
    $EDT_PATH/1cedtcli -data $TMP_PATH/ws -timeout 300 -v -command export --configuration-files $EXPORT_PATH/$PROJECT_NAME --project $ROOT_PATH/$PROJECT_PATH > $LOGS_PATH/$PROJECT_NAME.log 2>&1
fi
