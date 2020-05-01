#!/usr/bin/env bash

# Check args
if [ "$#" -ne 1 ]; then
  echo "Error! Usage should be: ./run.sh PROJECT_NAME"
  exit
fi

./docker_exec.sh $1 roscore