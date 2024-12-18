MODE=$1
JOB_NAME=${MODE}Application-File
TEST_DB_PATH=$DB_PATH/$MODE
CONNECTION_STRING=/F$TEST_DB_PATH

. $LIB_PATH/print.sh

rm -rf $TEST_DB_PATH

echo "=========== Подготовка информационной базы ${BOLD}$JOB_NAME${RESET}"
$ONEC_PATH/1cv8 CREATEINFOBASE File=$TEST_DB_PATH /DisableStartupDialogs /DisableStartupMessages /Out $LOGS_PATH/$JOB_NAME.log >> $LOGS_PATH/$JOB_NAME.log 2>&1
SUCCESS=$?
print_state "Создание информационной базы ${BOLD}$JOB_NAME${RESET}"

if [ $SUCCESS -ne 0 ]; then
    print_error "Не удалось создать базу ${BOLD}$JOB_NAME${RESET}"
    exit 0
fi

if $LIB_PATH/prepare-db.sh $CONNECTION_STRING $JOB_NAME; then
    print_info "Подготовлена база ${BOLD}$JOB_NAME${RESET}"
    $LIB_PATH/run-tests.sh $MODE $CONNECTION_STRING $JOB_NAME
else
    print_error "Не удалось подготовить базу ${BOLD}$JOB_NAME${RESET}"
fi