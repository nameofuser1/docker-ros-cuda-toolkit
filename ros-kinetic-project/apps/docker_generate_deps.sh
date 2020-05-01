#!/bin/bash

# This script generates list of ROS workspace external dependencies
# using rosdep

if [ "$#" -ne 2 ]; then
  echo "Error! Usage should be: ./docker_generate_deps.sh PROJECT_NAME ABSOLUTE_PATH_TO_ROS_WS"
  exit
fi

./docker_run.sh $1 $2 "/internal/generate_deps.sh"