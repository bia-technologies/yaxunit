#!/bin/bash

if [ -z "$ONEC_USERNAME" ]
then
    echo "ONEC_USERNAME not set"
    exit 1
fi

if [ -z "$ONEC_PASSWORD" ]
then
    echo "ONEC_PASSWORD not set"
    exit 1
fi

if [ -z "$ONEC_VERSION" ]
then
    echo "ONEC_VERSION not set"
    exit 1
fi

ONEC_RELEASE=`echo $ONEC_VERSION | cut -d . -f 3`
echo "Release: "$ONEC_RELEASE

echo "Downloading Oneget tool from https://github.com/firstBitMarksistskaya/oneget"
curl -L -o oneget.tar.gz https://github.com/firstBitMarksistskaya/oneget/releases/latest/download/oneget_Linux_x86_64.tar.gz \
   && mkdir /tmp/oneget_tool \
   && tar xzf oneget.tar.gz -C /tmp/oneget_tool \
   && rm oneget.tar.gz

if [ ! -f /tmp/oneget_tool/oneget ]; then
    echo "Oneget not found!"
    exit 1
fi

if [[ "$ONEC_RELEASE" -lt "20" ]]; then
    package="deb"
    package_installer_type="."$installer_type
else
    package="linux"
    package_installer_type=""
fi

case "$installer_type" in
  edt)
      echo "EDT"
      /tmp/oneget_tool/oneget get "edt:linux@"$ONEC_VERSION
      ;;
  server)
      /tmp/oneget_tool/oneget get "platform:"$package$package_installer_type".x64@"$ONEC_VERSION
      ;;
  server32)
      /tmp/oneget_tool/oneget get "platform:"$package${package_installer_type/32/}".x32@"$ONEC_VERSION
      ;;
  client)
      if [[ "$ONEC_RELEASE" -lt "20" ]]; then
      /tmp/oneget_tool/oneget get "platform:"$package".server.x64@"$ONEC_VERSION
      fi
      /tmp/oneget_tool/oneget get "platform:"$package$package_installer_type".x64@"$ONEC_VERSION
      ;;
  client32)
      if [[ "$ONEC_RELEASE" -lt "20" ]]; then
      /tmp/oneget_tool/oneget get "platform:"$package".server.x32@"$ONEC_VERSION
      fi
      /tmp/oneget_tool/oneget get "platform:"$package${package_installer_type/32/}".x32@"$ONEC_VERSION
      ;;
  thin-client)
      /tmp/oneget_tool/oneget get "platform:"$package"."$installer_type".x64@"$ONEC_VERSION
      ;;
  thin-client32)
      /tmp/oneget_tool/oneget get "platform:"$package"."${installer_type/32/}".x32@"$ONEC_VERSION
esac

