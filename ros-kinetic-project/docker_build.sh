#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Error! Usage should be: ./docker_exec.sh PROJECT_NAME PATH_TO_CATKIN_WS"
  exit
fi

cp $2/rosdep_deps.txt ./rosdep_deps.txt
docker build -t ros-kinetic-$1 .
rm ./rosdep_deps.txt

[ ! "$(docker ps -a | grep ros-kinetic-data-$1)" ] && docker create --name ros-kinetic-data-$1 ros-kinetic-$1