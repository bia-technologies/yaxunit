PROJECT_NAME=$1
PROJECT_PATH=$2

. $LIB_PATH/print.sh

function calc_hash {
    find $1 -type f -print0 | sort -z | xargs -0 sha1sum | sha1sum
}

hash_file_name=$EXPORT_PATH/$PROJECT_NAME.hash
current_hash=$(calc_hash $ROOT_PATH/$PROJECT_PATH/src);current_hash=${current_hash:0:40}

if [ -f $hash_file_name ]; then
    old_hash=$(head -n 1 $hash_file_name)
fi

if [[ "$current_hash" != "$old_hash" ]]; then
    print_warn "$PROJECT_NAME, исходники изменены. Будет выполнена сбора"
    rm -rf $EXPORT_PATH/$PROJECT_NAME
    rm -rf $BINARY_PATH/$PROJECT_NAME.*
    echo $current_hash>$hash_file_name
else
    print_success "$PROJECT_NAME, исходники не изменены. Будут использованы существующие артефакты"
fi
