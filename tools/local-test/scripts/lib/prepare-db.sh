CONNECTION_STRING=$1
JOB_NAME=$2

. $LIB_PATH/print.sh

BASE_ARGUMENTS="$CONNECTION_STRING /DisableStartupDialogs /DisableStartupMessages /Out $LOGS_PATH/$JOB_NAME.log"
DESIGNER_COMMAND="$ONEC_PATH/1cv8 DESIGNER $BASE_ARGUMENTS"

$DESIGNER_COMMAND /LoadCfg $BINARY_PATH/configuration.cf /UpdateDBCfg  >> $LOGS_PATH/$JOB_NAME.log 2>&1
SUCCESS=$?
print_state "Загрузка конфигурации в ${BOLD}$JOB_NAME${RESET}"
# cat $TMP_PATH/$JOB_NAME.log

EXTENSIONS_SET=("smoke" "tests" "yaxunit")

for key in "${EXTENSIONS_SET[@]}";do
    if [[ $SUCCESS -eq 0 ]]; then
        $DESIGNER_COMMAND /LoadCfg $BINARY_PATH/$key.cfe -Extension $key /UpdateDBCfg  >> $LOGS_PATH/$JOB_NAME.log 2>&1
        SUCCESS=$?
        print_state "Загрузка расширения $key в ${BOLD}$JOB_NAME${RESET}"
        # cat $TMP_PATH/$JOB_NAME.log
    fi
done

if [[ $SUCCESS -eq 0 ]]; then
    $ONEC_PATH/1cv8 ENTERPRISE $BASE_ARGUMENTS /Execute $LIB_PATH/DisableSafeMode.epf  >> $LOGS_PATH/$JOB_NAME.log 2>&1
    SUCCESS=$?
    print_state "Снятие безопасного режима ${BOLD}$JOB_NAME${RESET}"
    # cat $TMP_PATH/$JOB_NAME.log
fi

exit $SUCCESS