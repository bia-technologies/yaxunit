#!/bin/bash

# Установка из .deb пакетов
install_from_deb() {

    case "$installer_type" in
      server)
        if [ "$nls" = true ]; then
            dpkg -i 1c-enterprise*-{common,server}*.deb
        else
            dpkg -i 1c-enterprise*-{common,server}_*.deb
        fi
        ;;
      server_crs)
        if [ "$nls" = true ]; then
            dpkg -i "1c-enterprise*-{common,server,ws,crs}*.deb"
        else
            dpkg -i "1c-enterprise*-{common,server,ws,crs}_*.deb"
        fi
      ;;  
      client)
        if [ "$nls" = true ]; then
            dpkg -i "1c-enterprise*-{common,server,client}*.deb"
        else
            dpkg -i "1c-enterprise*-{common,server,client}_*.deb"
        fi
        ;;
      thin-client)
        if [ "$nls" = true ]; then
            dpkg -i "1c-enterprise83-thin-client*.deb"
        else
            dpkg -i "1c-enterprise83-thin-client_*.deb"
        fi
        ;;
    esac
}
# Установка из .run файла
install_from_run() {
    local run_components=""
    local run_file=$(ls *.run | head -1)

    if [ -z "$run_file" ]; then
        echo "Не найден файл установки .run"
        exit 1
    fi

    chmod +x "$run_file"

    if [ "$nls" = true ]; then 
      nls_install="az,ar,hy,bg,hu,el,vi,ka,kk,zh,it,es,lv,lt,de,pl,ro,ru,tr,tk,fr,uk"
    else
      nls_install="ru"
    fi

    case "$installer_type" in
      server)
        run_components="server,ws,config_storage_server,$nls_install"
        ;;
      server_crs) 
        run_components="server,ws,config_storage_server,$nls_install"
        ;;
      client)
        run_components="server,client_full,$nls_install"
        ;;
      client32)
        run_components="server,client_full,$nls_install"
        ;;
      thin-client)
        run_components="ru"
        ;;
      thin-client32)
        run_components="ru"
        ;;
    esac

    if [ -n "$run_components" ]; then
        ./"$run_file" --mode unattended --enable-components $run_components
    else
        echo "Не указаны компоненты для установки"
        exit 1
    fi
}

# Определяем, есть ли .deb файлы
if ls *.deb 1> /dev/null 2>&1; then
    echo "Установка из .deb пакетов"
    install_from_deb
elif ls *.run 1> /dev/null 2>&1; then
    echo "Установка из .run файла"
    install_from_run
else
    echo "Не найдены файлы установки"
    exit 1
fi