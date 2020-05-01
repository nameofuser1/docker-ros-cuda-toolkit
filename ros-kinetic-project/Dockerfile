FROM nameofuser1/ros-kinetic-gui-tools:cuda

VOLUME ["/root/"]
COPY internal /internal

# This file should contain apt-dependencies for your project
# You can get ROS dependincies using the following command
# rosdep install --simulate --reinstall --from-paths ~/catkin_ws/src --ignore-src
COPY rosdep_deps.txt /rosdep_deps.txt
RUN /bin/bash /rosdep_deps.txt

ENV ROS_DISTRO kinetic
ENTRYPOINT ["/internal/entrypoint.sh"]