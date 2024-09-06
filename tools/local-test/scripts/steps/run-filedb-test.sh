MODE=$1
JOB_NAME=${MODE}Application-File
TEST_DB_PATH=$DB_PATH/$MODE
CONNECTION_STRING=/F$TEST_DB_PATH

rm -rf $TEST_DB_PATH

echo "=========== Создание информационной базы ($JOB_NAME)"
$ONEC_PATH/1cv8 CREATEINFOBASE File=$TEST_DB_PATH /DisableStartupDialogs /DisableStartupMessages /Out $TMP_PATH/$JOB_NAME.log
cat $TMP_PATH/$JOB_NAME.log

if $LIB_PATH/prepare-db.sh $CONNECTION_STRING $JOB_NAME; then
    $LIB_PATH/run-tests.sh $MODE $CONNECTION_STRING $JOB_NAME
fi