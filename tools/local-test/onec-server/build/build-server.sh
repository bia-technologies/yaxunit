WORK_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

source $WORK_PATH/../../.env

mkdir -p $WORK_PATH/distr/current/
rm -rf $WORK_PATH/distr/current/*
cp -r $WORK_PATH/distr/$ONEC_VERSION/* $WORK_PATH/distr/current/

docker build \
     -t onec-server:$ONEC_VERSION \
    -f $WORK_PATH/Dockerfile \
    $WORK_PATH/