#!/bin/bash

ONEC_RELEASE=`echo $ONEC_VERSION | cut -d . -f 3`
echo "Release: "$ONEC_RELEASE
nls_install="ru"

if [[ "$ONEC_RELEASE" -lt "20" ]]; then
    case "$installer_type" in
      edt)
          echo "edt"
          ;;
      server)
          if [ "$nls" = true ]; then \
            dpkg -i 1c-enterprise*-{common,server}*.deb; \
          else \
            dpkg -i 1c-enterprise*-{common,server}_*.deb; \
          fi
          ;;
      server32)
          if [ "$nls" = true ]; then \
            dpkg -i 1c-enterprise*-{common,server,ws,crs}*.deb; \
          else \
            dpkg -i 1c-enterprise*-{common,server,ws,crs}_*.deb; \
          fi
          ;;
      client)
          if [ "$nls" = true ]; then \
            dpkg -i 1c-enterprise*-{common,server}_*.deb; \
            dpkg -i 1c-enterprise*-{common,client}*.deb; \
          else \
            dpkg -i 1c-enterprise*-{common,server,client}_*.deb; \
          fi
          ;;
      client32)
          ;;
      thin-client)
          if [ "$nls" = true ]; then \
            dpkg -i 1c-enterprise83-thin-client*.deb; \
          else \
            dpkg -i 1c-enterprise83-thin-client_*.deb; \
          fi
          ;;
      thin-client32)
	  curl --fail -b /tmp/cookies.txt -o thin-client32.tar.gz -L "$THINCLIENT32LINK"
    esac
else
    if [ "$nls" = true ]; then 
      nls_install="az,ar,hy,bg,hu,el,vi,ka,kk,zh,it,es,lv,lt,de,pl,ro,ru,tr,tk,fr,uk"
    else
      nls_install="ru"
    fi
    case "$installer_type" in
      edt)
          echo "edt"
          ;;
      server)
            set -x
	    echo $nls_install
	    ./setup-full-${ONEC_VERSION}-x86_64.run --mode unattended --enable-components server,ws,$nls_install
          ;;
      server32)
	    ./setup-full-${ONEC_VERSION}-i386.run --mode unattended --enable-components server,ws,config_storage_server,$nls_install
          ;;
      client)
	    ./setup-full-${ONEC_VERSION}-x86_64.run --mode unattended --enable-components server,client_full,$nls_install
          ;;
      client32)
	    ./setup-full-${ONEC_VERSION}-i386.run --mode unattended --enable-components server,client_full,$nls_install
          ;;
      thin-client)
	    ./setup-thin-${ONEC_VERSION}-x86_64.run --mode unattended --enable-components ru
          ;;
      thin-client32)
	    ./setup-thin-${ONEC_VERSION}-i386.run --mode unattended --enable-components ru
          ;;

    esac
fi
