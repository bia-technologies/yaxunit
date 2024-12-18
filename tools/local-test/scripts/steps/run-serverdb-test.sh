MODE=$1
JOB_NAME=${MODE}Application-Server
DB_NAME=DB_${MODE}Application
CONNECTION_STRING=/S\"localhost\\$DB_NAME\"

. $LIB_PATH/print.sh

echo "=========== Подготовка информационной базы ${BOLD}$JOB_NAME${RESET}"
$ONEC_PATH/1cv8 CREATEINFOBASE Srvr=localhost\;Ref=$DB_NAME\;DBMS=PostgreSQL\;DBSrvr=localhost\;DB=$DB_NAME\;DBUID=postgres\;CrSQLDB=Y\;SchJobDn=Y /DisableStartupDialogs /DisableStartupMessages /Out $LOGS_PATH/$JOB_NAME.log  >> $LOGS_PATH/$JOB_NAME.log 2>&1
SUCCESS=$?
print_state "Создание информационной базы ${BOLD}$JOB_NAME${RESET}"

if [ $SUCCESS -ne 0 ]; then
    print_error "Не удалось создать базу ${BOLD}$JOB_NAME${RESET}"
    exit 0
fi

if $LIB_PATH/prepare-db.sh $CONNECTION_STRING $JOB_NAME; then
    print_info "Подготовлена база для ${BOLD}$JOB_NAME${RESET}"
    $LIB_PATH/run-tests.sh $MODE $CONNECTION_STRING $JOB_NAME
else
    print_error "Не удалось создать базу для ${BOLD}$JOB_NAME${RESET}"
fi