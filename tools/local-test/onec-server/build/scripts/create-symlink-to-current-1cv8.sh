#!/bin/bash
set -e

platform_path=$(find / -type f -name "1cv8c" -exec dirname {} \; -or -type f -name "1cv8" -exec dirname {} \; -or -type f -name "ragent" -exec dirname {} \; -or -type f -name "crserver" -exec dirname {} \; | uniq)

mkdir -p /opt/1cv8 \
    && ln -s $platform_path /opt/1cv8/current
