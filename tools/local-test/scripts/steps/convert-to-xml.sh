PROJECT_NAME=$1
PROJECT_PATH=$2

if [[ -d $EXPORT_PATH/$PROJECT_NAME ]]; then
    echo "  Конвертация $PROJECT_NAME не требуется"
else
    echo "  Конвертация $PROJECT_NAME"
    $EDT_PATH/1cedtcli -data $TMP_PATH/ws -timeout 300 -command export --configuration-files $EXPORT_PATH/$PROJECT_NAME --project $ROOT_PATH/$PROJECT_PATH
fi
