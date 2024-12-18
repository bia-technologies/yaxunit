. $LIB_PATH/print.sh

MODE=$1
CONNECTION_STRING=$2
JOB_NAME=$3

CONFIG=$TMP_PATH/yaxunit-config-$JOB_NAME.json

case "$MODE" in
    "Ordinary"    ) APP=1cv8; RUN_MODE="/RunModeOrdinaryApplication";;
    "Thick"       ) APP=1cv8; RUN_MODE="/RunModeManagedApplication";;
    "Thin"        ) APP=1cv8c;;
esac

cat >$CONFIG <<EOL
{
    "reportFormat": "jUnit",
    "reportPath": "$RESULT_PATH/report-$JOB_NAME.xml",
    "closeAfterTests": true,
    "exitCode": "$RESULT_PATH/exit-code-$JOB_NAME.txt",
    "projectPath": "$ROOT_PATH",
    "logging": {
        "console": false
    }
}
EOL

echo "=========== Тестирование ${BOLD}$JOB_NAME${RESET}"
$ONEC_PATH/$APP ENTERPRISE $CONNECTION_STRING /DisableSplash /DisableStartupDialogs /DisableStartupMessages $RUN_MODE /C "RunUnitTests=$CONFIG" >> $LOGS_PATH/$JOB_NAME.log 2>&1

RESULT=$(head -n 1 $RESULT_PATH/exit-code-$JOB_NAME.txt)
RESULT=${RESULT:1:1}

if [[ "$RESULT" == "0" ]]; then
    print_success "Тестирование ${BOLD}$JOB_NAME${RESET} завершилось успешно"
else 
    print_error "Тестирование ${BOLD}$JOB_NAME${RESET} завершилось с ошибкой"
fi