MODE=$1
CONNECTION_STRING=$2
JOB_NAME=$3

CONFIG=$TMP_PATH/yaxunit-config-$JOB_NAME.json

case "$MODE" in
    "ordinary"    ) APP=1cv8; RUN_MODE="/RunModeOrdinaryApplication";;
    "thick"       ) APP=1cv8; RUN_MODE="/RunModeManagedApplication";;
    "thin"        ) APP=1cv8c;;
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

echo "Тестирование"
$ONEC_PATH/$APP ENTERPRISE $CONNECTION_STRING $RUN_MODE /DisableStartupDialogs /DisableStartupMessages /C "RunUnitTests=$CONFIG"
