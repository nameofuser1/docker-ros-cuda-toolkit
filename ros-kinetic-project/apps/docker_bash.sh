#!/bin/bash

# This script generates list of ROS workspace external dependencies
# using rosdep

if [ "$#" -ne 1 ]; then
  echo "Error! Usage should be: ./docker_generate_deps.sh PROJECT_NAME"
  exit
fi

./docker_exec.sh $1 /bin/bash