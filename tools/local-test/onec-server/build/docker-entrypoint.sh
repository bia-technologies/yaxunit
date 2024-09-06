#!/bin/bash

# Установка значений по умолчанию
setup_defaults() {
  DEFAULT_PORT=1540
  DEFAULT_REGPORT=1541
  DEFAULT_RANGE=1560:1591
  DEFAULT_SECLEVEL=0
  DEFAULT_PINGPERIOD=1000
  DEFAULT_PINGTIMEOUT=5000
  DEFAULT_DEBUG=-tcp
  DEFAULT_DEBUGSERVERPORT=1550
  DEFAULT_RAS_PORT=1545
}

# Настройка команды запуска ragent
setup_ragent_cmd() {
  RAGENT_CMD="gosu usr1cv8 /opt/1cv8/current/ragent"
  RAGENT_CMD+=" /port ${PORT:-$DEFAULT_PORT}"
  RAGENT_CMD+=" /regport ${REGPORT:-$DEFAULT_REGPORT}"
  RAGENT_CMD+=" /range ${RANGE:-$DEFAULT_RANGE}"
  RAGENT_CMD+=" /seclev ${SECLEVEL:-$DEFAULT_SECLEVEL}"
  RAGENT_CMD+=" /d ${D:-/home/usr1cv8/.1cv8}"
  RAGENT_CMD+=" /pingPeriod ${PINGPERIOD:-$DEFAULT_PINGPERIOD}"
  RAGENT_CMD+=" /pingTimeout ${PINGTIMEOUT:-$DEFAULT_PINGTIMEOUT}"
  RAGENT_CMD+=" /debug ${DEBUG:-$DEFAULT_DEBUG}"
  [ -n "$DEBUGSERVERADDR" ] && RAGENT_CMD+=" /debugServerAddr $DEBUGSERVERADDR"
  RAGENT_CMD+=" /debugServerPort ${DEBUGSERVERPORT:-$DEFAULT_DEBUGSERVERPORT}"
  [ -n "$DEBUGSERVERPWD" ] && RAGENT_CMD+=" /debugServerPwd $DEBUGSERVERPWD"
}

# Настройка команды запуска ras
setup_ras_cmd() {
  RAS_CMD="gosu usr1cv8 /opt/1cv8/current/ras cluster --daemon"
  RAS_CMD+=" --port ${RAS_PORT:-$DEFAULT_RAS_PORT}"
  RAS_CMD+=" localhost:${PORT:-$DEFAULT_PORT}"
}

# Изменение прав доступа к директории пользователя
change_directory_permissions() {
  chown -R usr1cv8:grp1cv8 /home/usr1cv8
}

# Главная функция скрипта
main() {
  setup_defaults
  change_directory_permissions

  if [ "$1" = "ragent" ]; then
    setup_ragent_cmd
    setup_ras_cmd

    echo "Запускаем ras с необходимыми параметрами"
    echo "Выполняемая команда: $RAS_CMD"
    $RAS_CMD 2>&1 &  # Запуск ras в фоновом режиме

    echo "Запускаем ragent с необходимыми параметрами"
    echo "Выполняемая команда: $RAGENT_CMD"
    exec $RAGENT_CMD 2>&1
  else
    # Если первый аргумент не 'ragent', выполняем команду, переданную в аргументах
    "$@"
  fi
}

# Вызов главной функции
main "$@"
