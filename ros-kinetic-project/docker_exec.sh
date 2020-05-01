#!/usr/bin/env bash

# Check args
if [ "$#" -ne 2 ]; then
  echo "Error! Usage should be: ./docker_exec.sh PROJECT_NAME APP_NAME"
  exit
fi

container_name="$(python internal/container_name.py --name $1)" 

docker exec\
  -e SHELL\
  -e DISPLAY=unix$DISPLAY\
  -e NO_AT_BRIDGE=1 \
  -e QT_X11_NO_MITSHM=1\
  -e XAUTHORITY=/tmp/.docker.xauth \
  --env="DISPLAY" \
  -it ${container_name} $2
