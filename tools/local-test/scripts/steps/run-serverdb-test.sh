MODE=$1
JOB_NAME=${MODE}Application-Server
DB_NAME=DB_${MODE}Application
CONNECTION_STRING=/S\"localhost\\$DB_NAME\"

echo "=========== Создание информационной базы ($JOB_NAME)"
$ONEC_PATH/1cv8 CREATEINFOBASE Srvr=localhost\;Ref=$DB_NAME\;DBMS=PostgreSQL\;DBSrvr=localhost\;DB=$DB_NAME\;DBUID=postgres\;CrSQLDB=Y\;SchJobDn=Y /DisableStartupDialogs /DisableStartupMessages /Out $TMP_PATH/$JOB_NAME.log >&- 2>&-
# cat $TMP_PATH/$JOB_NAME.log

if $LIB_PATH/prepare-db.sh $CONNECTION_STRING $JOB_NAME; then
    $LIB_PATH/run-tests.sh $MODE $CONNECTION_STRING $JOB_NAME
fi