#!/bin/bash

cd /root/catkin_ws && rosdep install --simulate --from-paths ./src --ignore-src > rosdep_deps.txt
python /internal/deps_post_processing.py -f /root/catkin_ws/rosdep_deps.txt