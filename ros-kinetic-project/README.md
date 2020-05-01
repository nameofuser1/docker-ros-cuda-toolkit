### Docker container with ROS kinetic and Nvidia + OpenGL support

## Requirements ##

Linux, nvidia graphics card, nvidia-docker2. Also CUDA10 is installed therefore take a look at [driver requirements][1].

## Description

Container which can be used for ROS development. It contains machine learning toolkit which includes tensorflow, keras, dlib and CUDA support. If you want to use machine learning tools you have to install nvidia-docker2.

Also container includes QtCreator with ROS plugin. In order to be able to run graphical tools OpenGL support for nvidia cards is added. For this to work you should also use nvidia-docker2. For CPU built-in graphics chip you can install mesa libraries and mount device driver into container. Nevertheless right now container **requires nvidia card and nvidia-docker2** for it to work.

## How does it work

There are bunch of scripts you can use to make everything work. All the script **MUST** be called from the within **ros-kinetic-project** directory.

### Building container

First script you are likely to use is `docker_build.sh [PROJECT_NAME] [ABSOLUTE PATH TO CATKIN_WS]`. It will build docker image for you and bind it to your project name. In partcular it will create image with name `ros-kinetic-[PROJECT_NAME]`. On top of that it will create data volume for the container with name `ros-kinetic-data-[PROJECT_NAME]` if it does not exist yet.

Several steps are required for building a container:

1. Create rosdep_deps.txt inside your catkin workspace directory. It should contain all the apt dependencies for your project. You will be able to generate ROS packages dependencies using `apps/docker_generate_deps.sh` script once you built a container. At first run it is ok for this file to be empty. Each time you have new apt dependency you have to rebuild image. Fortunately docker will do it fast since it is done in the last layer.

### Example of building a container:

We will build image for PR2 simulator package. The following commands will do:

```
mkdir -p ~/PR2Project/catkin_ws/src && cd ~/PR2Project/catkin_ws/src && git clone https://github.com/PR2/pr2_simulator
cd ~/PR2Project && touch catkin_ws/rosdep_deps.txt
git clone https://github.com/nameofuser1/docker-ros-kinetic-project
cd ~/PR2Project/docker-ros-kinetic-project && ./docker_build.sh pr2 $(pwd)/../catkin_ws 
```

However now `pr2_simulator` package still can not be built because of unment dependencies. To resolve them we can run `docker_generate_deps.sh` and rebuild image.

```
cd ~/PR2Project/docker-ros_kinetic_project && apps/docker_generate_deps.sh pr2 $(pwd)/../catkin_ws
docker_build.sh pr2 $(pwd)/../catkin_ws
```

Now our image is ready to use.

### Running a container

[1]: https://docs.nvidia.com/deploy/cuda-compatibility/index.html