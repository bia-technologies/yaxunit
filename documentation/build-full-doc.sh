#!/bin/bash

# download https://github.com/1CDevFlow/BSL-Doc/releases/download/0.1.0/bsldoc-0.1.0.jar to ./bsldoc.jar
CURRENT_PATH=$(pwd)

java -jar $CURRENT_PATH/bsldoc.jar $CURRENT_PATH/../exts/yaxunit $CURRENT_PATH/api -f Docusaurus -s ЮТДвижок
yarn start