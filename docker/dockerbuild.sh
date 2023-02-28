#!/bin/sh

set -e

PWD=`pwd`
if [ `basename "$PWD"` = 'docker' ]
then
  echo "try cd .. && ./docker/dockerbuild.sh \`pwd\`"
  exit 1
fi

if [ `arch` = "arm64" ]
then
  echo "arm64 detected, so, set platform to linux/amd64"
  PLATFORM=--platform=linux/amd64
else
  PLATFORM=
fi

if [ -d "$1" ] 
then

  echo "==============="
  echo "=  LCPSERVER  ="
  echo "==============="
  docker build -f docker/Dockerfile --build-arg PORT="8989" --build-arg SERVER_CMD="/usr/bin/lcpserver" -t lcpserver:latest $PLATFORM $1

  echo "==============="
  echo "=  LSDSERVER  ="
  echo "==============="
  docker build -f docker/Dockerfile --build-arg PORT="8990" --build-arg SERVER_CMD="/usr/bin/lsdserver" -t lsdserver:latest $PLATFORM $1

  echo "==============="
  echo "=  FRONTEND   ="
  echo "==============="
  docker build -f docker/Dockerfile --build-arg PORT="8991" --build-arg SERVER_CMD="/usr/bin/frontend" -t frontendtestserver:latest $PLATFORM $1

else
  echo "ERROR arg '$1' doesn't exists"
  echo "try $0 \`pwd\`"
  exit 1

fi
