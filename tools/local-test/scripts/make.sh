export SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

source $SCRIPTPATH/../.env

export EDT_PATH=/opt/1C/1CE/components/1c-edt-$EDT_VERSION-x86_64
export ONEC_PATH=/opt/1cv8/x86_64/$ONEC_VERSION

export WORK_PATH=$(realpath $SCRIPTPATH/../workpath)
export ROOT_PATH=$(realpath $SCRIPTPATH/../../../)

export TMP_PATH=$WORK_PATH/tmp
export DB_PATH=$WORK_PATH/file-db
export EXPORT_PATH=$WORK_PATH/export
export BINARY_PATH=$WORK_PATH/binary
export RESULT_PATH=$WORK_PATH/result


mkdir -p $DB_PATH
mkdir -p $EXPORT_PATH
mkdir -p $BINARY_PATH

mkdir -p $TMP_PATH
mkdir -p $RESULT_PATH

rm -rf $TMP_PATH/*
rm -rf $RESULT_PATH/*

cat >~/.1cv8/1C/1cv8/conf/conf.cfg <<EOL
DisableUnsafeActionProtection=.*
EOL

# $SCRIPTPATH/convert-to-xml.sh
# $SCRIPTPATH/build-artifacts.sh

echo "=================== Запуск тестирования ========================="
$SCRIPTPATH/test-filedb-ordinary.sh &
$SCRIPTPATH/test-filedb-thick.sh &
$SCRIPTPATH/test-filedb-thin.sh &

wait