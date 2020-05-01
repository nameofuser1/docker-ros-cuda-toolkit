FROM nameofuser1/cuda-machine-learning-toolkit:latest

# Set apt mirror to ucmirror and install extra packages
RUN apt-get update && \
	apt-get install -y --allow-unauthenticated \
		bash-completion \
		nano \
		tmux \
		psmisc \
		software-properties-common \
		autoconf \
		libxext-dev \
		libx11-dev \
		x11proto-gl-dev \
		git \
		tig \
		mc \
		wget \
		apt-utils && \
	rm -rf /var/lib/apt/lists/*

# Install Qt creator 4.2.2 for development
RUN add-apt-repository -y ppa:beineri/opt-qt571-xenial &&  \
	add-apt-repository -y ppa:levi-armstrong/qt-libraries-xenial && \
	add-apt-repository ppa:levi-armstrong/ppa && \
	apt-get update && \
	apt-get install -y --allow-unauthenticated qt59creator dbus clang-format-3.9 &&\
	apt-get install -y --allow-unauthenticated qt57creator-plugin-ros &&\
	ln -s /opt/qt57/bin/qtcreator /usr/local/bin/qtcreator

# Install ROS Kinetic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
	apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 && \
	apt-get update && \
	apt-get install -y --allow-unauthenticated ros-kinetic-desktop-full ros-kinetic-rosbash && \
	rosdep init && \
	rosdep update && \
	echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc

# Install libglvnd in order to provide OpenGL support
RUN git clone https://github.com/NVIDIA/libglvnd && \
	cd libglvnd && ./autogen.sh && ./configure && make -j$(nproc) &&  make install && \
	ldconfig && rm -rf /llibglvnd

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,video,graphics,display,utility

# Refer to https://bugreports.qt.io/browse/QTBUG-58508
ENV QML_DISABLE_DISK_CACHE=1