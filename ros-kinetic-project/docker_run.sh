#!/usr/bin/env bash

# Check args
if [ "$#" -ne 2 ] && [ "$#" -ne 3 ]; then
  echo "Error! Usage should be: ./run.sh PROJECT_NAME ABSOLUTE_PATH_TO_ROS_WS [app name]"
  exit
fi


if [ "$#" -ne 3 ];
then
  APP=/bin/bash
else
  APP=$3
fi

xhost +si:localuser:root

docker run\
  -e SHELL\
  -e NO_AT_BRIDGE=1 \
  --env="DISPLAY=unix$DISPLAY" \
  --env="QT_X11_NO_MITSHM=1" \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  -v "$2:/root/catkin_ws" \
  --net=host \
  --gpus all \
  -it --rm \
  --volumes-from ros-kinetic-data-$1 \
  ros-kinetic-$1 $APP