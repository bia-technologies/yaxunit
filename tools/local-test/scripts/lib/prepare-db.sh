CONNECTION_STRING=$1
JOB_NAME=$2

BASE_ARGUMENTS="$CONNECTION_STRING /DisableStartupDialogs /DisableStartupMessages /Out $TMP_PATH/$JOB_NAME.log"
DESIGNER_COMMAND="$ONEC_PATH/1cv8 DESIGNER $BASE_ARGUMENTS"

echo "=========== Загрузка конфигурации ($JOB_NAME)"
$DESIGNER_COMMAND /LoadCfg $BINARY_PATH/configuration.cf /UpdateDBCfg >&- 2>&-
SUCCESS=$?
# cat $TMP_PATH/$JOB_NAME.log

EXTENSIONS_SET=("smoke" "tests" "yaxunit")

for key in "${EXTENSIONS_SET[@]}";do
    if [[ $SUCCESS -eq 0 ]]; then
        echo "=========== Загрузка расширения $key ($JOB_NAME)"
        $DESIGNER_COMMAND /LoadCfg $BINARY_PATH/$key.cfe -Extension $key /UpdateDBCfg >&- 2>&-
        SUCCESS=$?
        # cat $TMP_PATH/$JOB_NAME.log
    fi
done

if [[ $SUCCESS -eq 0 ]]; then
    echo "=========== Снятие безопасного режима ($JOB_NAME)"
    $ONEC_PATH/1cv8 ENTERPRISE $BASE_ARGUMENTS /Execute $LIB_PATH/DisableSafeMode.epf >&- 2>&-
    SUCCESS=$?
    # cat $TMP_PATH/$JOB_NAME.log
fi

exit $SUCCESS