#!/usr/bin/env bash

# Check args
if [ "$#" -ne 1 ]; then
  echo "Error! Usage should be: ./docker_qtcreator.sh PROJECT_NAME"
  exit
fi

./docker_exec.sh $1 "qtcreator-ros -theme flat-dark"
